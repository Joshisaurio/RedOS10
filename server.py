import scratchattach as scratchattach
import encoder as encoder
import utilities
from time import time, sleep
import threading
import os
import sys
import traceback
import requests
from io import BytesIO
from PIL import Image
import random
import string
import bcrypt
import discord
from discord.ext import commands
from discord import Interaction, Attachment
import asyncio
from datetime import datetime, timedelta, timezone
import json
import math
import subprocess
import requests
from bs4 import BeautifulSoup
import urllib.parse
import trafilatura
import ipaddress
import socket
import re

LOG_TO_FILE = True

os.chdir(os.path.dirname(os.path.abspath(__file__)))
if LOG_TO_FILE:
    if not os.path.exists("logs"):
        os.makedirs("logs")
    server_log_file = open("logs/server.log", "a")

if not os.path.exists("saves"):
    os.makedirs("saves")

def log_server(text):
    print_str = f"{utilities.get_now_str()} {text}"
    if LOG_TO_FILE:
        print(print_str, file=server_log_file, flush=True)
    else:
        print(print_str)

def error_server():
    log_server(f"Error:\n{traceback.format_exc()}")

log_server("server started")
 
VERIFICATION_ID = "1153014815"
verification_project: scratchattach.Project = utilities.dont_print(scratchattach.get_project, VERIFICATION_ID)

var_queue = []

methodes = {}
def methode(name):
    def decorator(func):
        global methodes
        methodes[name] = func
        return func
    return decorator

class ReturnError(Exception): ...


########################################################
##                                                    ##
##                        APPS                        ##
##                                                    ##
########################################################

@methode("base")
def app_base(text: str) -> list:
    return [text]

@methode("system.ping")
def app_system_ping(text: str) -> list:
    return [text]

users = utilities.Storage("saves/users.json")

def get_user_data(username: str) -> dict:
    username = username.lower()
    user_data = users.get(username.lower())
    if not user_data:
        raise ReturnError(f"user '{username}' does not exist")
    return user_data

def get_scratch_user(username: str) -> scratchattach.User:
    try:
        return utilities.dont_print(scratchattach.get_user, username)
    except scratchattach.utils.exceptions.UserNotFound:
        raise ReturnError("user not found")

def login(username: str, password: str) -> dict:
    user_data = get_user_data(username)
    user_password = user_data.get("password")
    if not user_password:
        raise ReturnError(f"user '{user_data['username']}' does not have a password")
    is_correct = bcrypt.checkpw(password.lower().encode(), user_password.encode())
    if not is_correct:
        if bcrypt.checkpw(password.encode(), user_password.encode()):
            user_data["password"] = bcrypt.hashpw(password.lower().encode(), bcrypt.gensalt()).decode()
        else:
            raise ReturnError(f"wrong password")
    return user_data

def check_verified(user_data: dict) -> None:
    if not user_data.get("verified"):
        raise ReturnError(f"user '{user_data['username']}' is not verified")

def check_ban(user_data: dict) -> None:
    if user_data.get("ban"):
        last_ban = utilities.from_timestamp(user_data["ban"]) - datetime.now(timezone.utc)
        if last_ban > timedelta():
            raise ReturnError(f"banned for {math.ceil(last_ban.seconds/60)} minutes")

def get_verification(user_data: dict) -> dict:
    verification = user_data.get("verification")
    if not verification:
        raise ReturnError(f"user '{user_data['username']}' does not have a verification code")
    if datetime.now(timezone.utc) - utilities.from_timestamp(verification["timestamp"]) > timedelta(minutes=10):
        raise ReturnError(f"user '{user_data['username']}' does not have an active verification code")
    return verification

def return_login_data(user_data: dict) -> list:
    return [user_data["username"], user_data.get("verified", False)] + app_pfp(user_data["username"]) + get_settings(user_data)

@methode("system.login")
def app_system_login(username: str, password: str) -> list:
    user_data = login(username, password)
    user_data["last_login"] = utilities.get_now_str()
    return return_login_data(user_data)

@methode("system.signup")
def app_system_signup(username: str, password: str) -> list:
    if len(password) < 3:
        raise ReturnError(f"password has to have at least 3 digits")
    user = get_scratch_user(username)
    user_data = users.get(username.lower())
    if user_data: raise ReturnError("user already exists", user_data["username"])

    password_hash = bcrypt.hashpw(password.lower().encode(), bcrypt.gensalt()).decode()
    users[username.lower()] = {"username": user.username, "password": password_hash, "created": utilities.get_now_str(), "last_login": utilities.get_now_str(), "messages": []}
    if len(users.keys()) in [100, 500, 1000, 5000, 10000]:
        log_server(f"!!! Welcome our {len(users.keys())}th user: {user.username}")
    return return_login_data(users[username.lower()])

@methode("system.reset_password")
def app_system_reset_password(username: str, password: str, private_code: str) -> list:
    if len(password) < 3:
        raise ReturnError(f"password has to have at least 3 digits")
    user_data = get_user_data(username)
    verification = get_verification(user_data)

    if not verification["private"] == private_code:
        raise ReturnError("wrong private code")
    
    password_hash = bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()
    user_data["password"] = password_hash
    return return_login_data(user_data)

@methode("system.get_verification")
def app_system_get_verification(username: str) -> list:
    user_data = get_user_data(username)
    
    verification_code_public = ''.join(random.choices(string.ascii_letters + string.digits, k=40))
    verification_code_private = ''.join(random.choices(string.ascii_letters + string.digits, k=40))
    user_data["verification"] = {"public": verification_code_public, "private": verification_code_private, "timestamp": utilities.get_now_str()}
    return [user_data["username"], verification_project.url, verification_code_public, verification_code_private]

@methode("system.check_verification")
def app_system_check_verification(username: str) -> list:
    user_data = get_user_data(username)
    verification = get_verification(user_data)

    has_commented = False
    other_users = []
    for comment in verification_project.comments():
        if comment.content.count(verification["public"]):
            if comment.author_name.lower() == user_data["username"].lower():
                has_commented = True
            elif not comment.author_name in other_users:
                other_users.append(comment.author_name)
    if not has_commented:
        if len(other_users) == 0:
            raise ReturnError(f"user '{username}' didn't comment the correct code")
        else:
            raise ReturnError(f"comment with '{username}' and not with {', '.join(other_users)}")
    user_data["verified"] = True
    return [username]

@methode("system.is_verified")
def app_system_is_verified(username: str) -> list:
    user_data = get_user_data(username)
    return [user_data.get("verified", False)]

pfp_cache = {}
@methode("pfp")
def app_pfp(username: str) -> list:
    global pfp_cache
    cache_result = pfp_cache.get(username.lower())
    if cache_result:
        return [encoder.Number(cache_result)]
    user = get_scratch_user(username)

    size: int = 64
    colors: int = 99

    url = f"https://uploads.scratch.mit.edu/get_image/user/{user.id}_{size}x{size}.png"
    response = requests.get(url)
    image = Image.open(BytesIO(response.content)).resize((size, size), Image.LANCZOS).convert("RGBA")

    background = Image.new("RGB", image.size, (255, 255, 255))
    background.paste(image, mask=image.split()[3])
    image = background.convert("P", palette=Image.ADAPTIVE, colors=colors)

    def color2str(rgb):
        color_str = ""
        for channel in (rgb[0], rgb[1], rgb[2]):
            color_str += "{:02d}".format(int(round(float(channel)/255*99)))
        return color_str

    pixel_list = list(image.getdata())
    palette = image.getpalette()
    pixel_set = [color2str(tuple(palette[i:i+3])) for i in range(0, len(palette), 3)]
    index_len = int(math.log10(len(pixel_set)))+1

    response = ""
    response += str(index_len)
    response += str(len(pixel_set))
    response += "".join(pixel_set)

    last_pixel = None
    count = 0
    for pixel in pixel_list:
        color_idx = f"{pixel:0{index_len}d}".format(pixel)
        if color_idx == last_pixel and count < 9:
            count += 1
        else:
            if last_pixel != None:
                response += "{:01d}".format(count) + last_pixel
            last_pixel = color_idx
            count = 0
    response += "{:01d}".format(count) + color_idx
    return [encoder.Number(response)]

@methode("set_settings")
def app_set_settings(username: str, password: str, *args) -> list:
    user_data = login(username, password)
    if not user_data.get("settings"):
        user_data["settings"] = {}
    i = 0
    while i+1 < len(args):
        if args[i] != "admin":
            user_data["settings"][args[i]] = args[i+1]
        i += 2
    return [username]

def get_settings(user_data: dict) -> list:
    settings = ["admin", user_data.get("admin", False)]
    for key, value in user_data.get("settings", {}).items():
        settings.append(key)
        settings.append(value)
    return settings

@methode("get_settings")
def app_get_settings(username: str, password: str) -> list:
    user_data = login(username, password)
    return get_settings(user_data)

request_count = 0
@methode("weather")
def app_weather(city_name: str) -> list:
    global request_count
    base_url = "http://api.openweathermap.org/data/2.5/weather"

    complete_url = f"{base_url}?appid={WEATHER_TOKEN}&q={city_name}&units=metric"
    request_count += 1
    response = requests.get(complete_url)
    answer: dict = response.json()

    match str(answer["cod"]):
        case "200": pass # OK
        case _: raise ReturnError(answer.get("message", answer["cod"]))

    current_temperature = answer["main"]["temp"]
    weather_description = answer["weather"][0]["description"]

    return [
        current_temperature,
        weather_description
    ]

discord_messages = utilities.Storage("saves/discord.json")
@methode("discord.post")
def app_discord_post(username: str, password: str, text: str) -> list:
    text = bytes(text, "utf-8").decode("unicode_escape")
    username = username.lower()
    user_data = login(username, password)
    # check_verified(user_data)
    check_ban(user_data)
    if utilities.is_profane(text):
        log_server(f"Profane message to discord by {user_data['username']}: {text}")
        user_data["ban"] = (datetime.now(timezone.utc) + timedelta(minutes=10)).replace(microsecond=0).strftime(utilities.FORMAT)
        user_data["ban_reason"] = "Profane message to discord"
        raise ReturnError("profane")
    message_id = send_discord_message_from_user(user_data["username"], text)
    discord = user_data.get("discord")
    if discord is None:
        user_data["discord"] = []
        discord = user_data["discord"]
    discord.append(message_id)
    return []

@methode("messages.get")
def app_messages_get(username: str, password: str) -> list:
    username = username.lower()
    user_data = login(username, password)
    messages: list = user_data.get("messages", [])
    if (len(messages) == 0):
        messages.append([utilities.get_days_since_2000(utilities.from_timestamp(user_data["created"])), "welcome"])
    messages.sort(reverse=True)
    user_data["messages"] = messages
    message_list = []
    for message in messages:
        message_summary = None
        message_content = None
        match message[1]:
            case "welcome":
                message_summary = "Welcome"
                message_content = f"Hello {user_data['username']},\nWelcome to Red OS!"
            case "discord":
                message_summary = "Support"
                discord_message = discord_messages.get(str(message[2]))
                if discord_message is None: continue
                your_message = discord_message["text"]
                response_message = discord_message["responses"].get(message[3])["text"]
                if response_message is None: continue
                message_content = f"{response_message}\n\n\\i\\bYour message:\\b\n{your_message}\\i"
        if message_content is None: continue
        message_list.append(f"\\b{message_summary}\\b \\i{utilities.get_date_str(message[0])}\\i\n{message_content}")
    return message_list

llm_messages = utilities.Storage("saves/llm.json")
@methode("llm.post")
def app_llm_post(username: str, password: str, text: str, new_conversation: str = "0") -> list:
    username = username.lower()
    user_data = login(username, password)
    check_ban(user_data)
    if utilities.is_profane(text):
        log_server(f"Profane message to llm by {user_data['username']}: {text}")
        user_data["ban"] = (datetime.now(timezone.utc) + timedelta(minutes=10)).replace(microsecond=0).strftime(utilities.FORMAT)
        user_data["ban_reason"] = "Profane message to llm"
        raise ReturnError("profane")
    
    llm = user_data.get("llm")
    if llm is None:
        user_data["llm"] = []
        llm = user_data["llm"]
        new_conversation = "1"
    if new_conversation == "1" or new_conversation.lower() == "true":
        llm.append([])
    message_id, answer = send_llm_message(user_data["username"], text, llm[-1])
    llm[-1].append(message_id)
    return [answer]

@methode("llm.list")
def app_llm_list(username: str, password: str) -> list:
    username = username.lower()
    user_data = login(username, password)
    llm = user_data.get("llm", [])
    llm_list = []
    for message_id in llm:
        llm_list.append(message_id)
        llm_list.append(llm_messages.get(str(message_id), {}).get("text", "None"))
    return llm_list


PRIVATE_NETS = [
    ipaddress.ip_network("127.0.0.0/8"),       # loopback
    ipaddress.ip_network("10.0.0.0/8"),        # private
    ipaddress.ip_network("172.16.0.0/12"),     # private + docker bridge
    ipaddress.ip_network("192.168.0.0/16"),    # private
    ipaddress.ip_network("169.254.0.0/16"),    # link-local
    ipaddress.ip_network("::1/128"),           # IPv6 loopback
    ipaddress.ip_network("fe80::/10"),         # IPv6 link-local
    ipaddress.ip_network("fc00::/7"),          # IPv6 private
]

BLOCKED_HOSTNAMES = {
    "localhost",
    "ip6-localhost",
    "host.docker.internal",
}


my_ipv4_pattern = None
my_ipv6_pattern = None
def get_my_ip():
    global my_ipv4_pattern, my_ipv6_pattern
    resp = requests.get('https://api.ipify.org')
    resp.raise_for_status()
    octets = resp.text.strip().split('.')
    my_ipv4_pattern = r'\b' + r'\.'.join(
        fr'0*{int(octet)}' for octet in octets
    ) + r'\b'

    resp = requests.get('https://ifconfig.me/ip')
    resp.raise_for_status()
    text = resp.text.strip()
    my_ipv6_pattern = re.escape(text)

def is_ip_private(ip: str) -> bool:
    addr = ipaddress.ip_address(ip)
    if (addr.is_private
        or addr.is_loopback
        or addr.is_link_local
        or addr.is_reserved
        or addr.is_multicast):
        return True
    for net in PRIVATE_NETS:
        if addr in net:
            return True
    return False

def resolve_hostname(hostname: str) -> str:
    try:
        infos = socket.getaddrinfo(hostname, None)
        for family, _, _, _, sockaddr in infos:
            if family == socket.AF_INET:
                return sockaddr[0]
        return infos[0][4][0]
    except Exception:
        raise ReturnError(f"Could not resolve hostname: {hostname}")


def fetch_response(url: str, timeout: float = 5.0) -> str:
    try:
        if not (url.startswith("https://") or url.startswith("http://")):
            url = "https://" + url
        
        parsed = urllib.parse.urlparse(url)
        if parsed.scheme not in {"http", "https"}:
            raise ReturnError("Only HTTP/HTTPS is allowed")
        if not parsed.hostname:
            raise ReturnError("Invalid URL without hostname")
        
        hostname = parsed.hostname.lower()
        if hostname in BLOCKED_HOSTNAMES:
            raise ReturnError("Blocked private hostname")
        
        ip = resolve_hostname(hostname)
        if is_ip_private(ip):
            raise ReturnError("Blocked internal/private IP")
    
        headers = {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36"
        }
        response = requests.get(url, headers=headers, timeout=timeout)
        response.raise_for_status()
    except requests.exceptions.MissingSchema:
        raise ReturnError("Invalid URL (missing Schema?)")
    except requests.exceptions.InvalidURL:
        raise ReturnError("Invalid URL")
    except requests.exceptions.ConnectionError:
        raise ReturnError("Connection Error (DNS, Network?)")
    except requests.exceptions.Timeout:
        raise ReturnError("Timeout")
    except requests.exceptions.HTTPError as e:
        raise ReturnError(f"HTTP Error: {e.response.status_code}")
    except requests.exceptions.SSLError:
        raise ReturnError("SSL Error")
    except ReturnError as e:
        raise e
    except Exception as e:
        error_server()
        raise ReturnError("Some Error occured. Please report this to @KROKOBIL")
    if (my_ipv4_pattern is None): get_my_ip()
    html = response.text
    if re.search(my_ipv4_pattern, html) or re.search(my_ipv6_pattern, html):
        raise ReturnError(f"Blocked website for privacy reasons")
    return html

@methode("search")
def app_search(query: str) -> list:
    if utilities.is_profane(query):
        raise ReturnError("Don't search for profane words.")
    url = f"https://duckduckgo.com/html/?q={urllib.parse.quote(query)}&kp=1"
    html = fetch_response(url)
    soup = BeautifulSoup(html, "html.parser")

    if soup.find("div", class_="anomaly-modal__mask"):
        raise ReturnError("Search limit reached. Try again in a few minutes.")
    
    return_list = []

    for result in soup.find_all("div", class_="result"):
        link_tag = result.find("a", class_="result__a")
        snippet_tag = result.find("a", class_="result__snippet")
        
        if link_tag:
            title = link_tag.get_text(strip=True)

            parsed = urllib.parse.urlparse(link_tag["href"])
            uddg_value = urllib.parse.parse_qs(parsed.query).get("uddg", [None])[0]
            if not uddg_value:
                continue
            clean_url = urllib.parse.unquote(uddg_value)

            snippet = snippet_tag.get_text(strip=True) if snippet_tag else ""

            if not utilities.is_profane(title + " ; " + clean_url + " ; " + snippet):
                return_list.append(title)
                return_list.append(clean_url)
                return_list.append(snippet)

    return return_list

@methode("website")
def app_website(url: str) -> list:
    if utilities.is_profane(url):
        raise ReturnError("Don't open profane websites")
    html = fetch_response(url)

    result = trafilatura.extract(
        html,
        include_comments=False,
        include_tables=False,
        no_fallback=True
    )

    if result is None:
        raise ReturnError("The website isn't readable")

    if len(result) > 1000:
        result = result[:1000]

    if utilities.is_profane(result):
        raise ReturnError("Don't open profane websites")

    return [result]


appstore = utilities.Storage("saves/appstore.json", 1)
if (not appstore.get("public")): appstore["public"] = {}
if (not appstore.get("requested")): appstore["requested"] = {}

@methode("appstore_get_all")
def app_appstore_get_all(_) -> list:
    all_apps = []
    for app in appstore.get("public", {}).values():
        all_apps.append(app["name"])
        all_apps.append(app["username"])
        all_apps.append(app["icon"])
    return all_apps

@methode("appstore_get_requested")
def app_appstore_get_all(username: str, password: str) -> list:
    user_data = login(username, password)
    if (not user_data.get("admin", False)): raise ReturnError("Admin account required")
    all_apps = []
    for app in appstore.get("requested", {}).values():
        all_apps.append(app["name"])
        all_apps.append(app["username"])
        all_apps.append(app["icon"])
    return all_apps

@methode("appstore_get_app")
def app_appstore_get_app(app_id: str) -> list:
    app = appstore["public"].get(app_id, None)
    if (not app): raise ReturnError("App not found")
    return [app["name"], app["icon"], app["code"]]

@methode("appstore_get_requested_app")
def app_appstore_get_requested_app(username: str, password: str, app_name: str) -> list:
    user_data = login(username, password)
    if (not user_data.get("admin", False)): raise ReturnError("Admin account required")

    app = appstore["requested"].get(app_name, None)
    if (not app): raise ReturnError("App not found")
    return [app["name"], app["icon"], app["code"]]

@methode("appstore_approve_app")
def app_appstore_approve_app(username: str, password: str, app_name: str) -> list:
    user_data = login(username, password)
    if (not user_data.get("admin", False)): raise ReturnError("Admin account required")
    
    app = appstore["requested"].get(app_name, None)
    if (not app): raise ReturnError("App not found")
    appstore["public"][app_name] = app
    del appstore["requested"][app_name]
    return []

@methode("appstore_reject_app")
def app_appstore_reject_app(username: str, password: str, app_name: str) -> list:
    user_data = login(username, password)
    if (not user_data.get("admin", False)): raise ReturnError("Admin account required")
    
    app = appstore["requested"].get(app_name, None)
    if (not app): raise ReturnError("App not found")
    del appstore["requested"][app_name]
    return []

@methode("appstore_add")
def app_appstore_add(username: str, password: str, app_name: str, app_icon: str, app_code: str) -> list:
    user_data = login(username, password)
    if utilities.is_profane(app_name + ": " + app_code):
        log_server(f"Profane app uploaded by {user_data['username']}: {app_name + ': ' + app_code}")
        user_data["ban"] = (datetime.now(timezone.utc) + timedelta(minutes=10)).replace(microsecond=0).strftime(utilities.FORMAT)
        user_data["ban_reason"] = "Profane app uploaded"
        raise ReturnError("profane")
    if len(app_name.replace(" ", "")) == 0:
        raise ReturnError("App name is empty")
    app = {
        "name": app_name,
        "username": user_data["username"],
        "icon": app_icon,
        "code": app_code
    }
    old_app = appstore["requested"].get(app_name)
    if not old_app: old_app = appstore["public"].get(app_name)
    if old_app:
        if old_app["username"] != app["username"]:
            raise ReturnError("Another user owns this app.")
    appstore["requested"][app_name] = app
    if old_app:
        send_discord_message(f"**{username}** updated the app *{app_name}*")
    else:
        send_discord_message(f"**{username}** uploaded a new app *{app_name}*")
    return []

########################################################

### shutdown ###

stop_event = threading.Event()

is_shutdown = False

general = None

def restart():
    shutdown()
    os.execv(sys.executable, [sys.executable] + sys.argv)

def shutdown():
    global is_shutdown
    if is_shutdown: return
    if general:
        for id, _ in general["projects"]:
            events[id].stop()
            cloud[id].disconnect()
    stop_event.set()
    log_server("saving...")
    utilities.save_all_storage_instances()
    log_server("server stopped")
    if LOG_TO_FILE:
        server_log_file.close()
    is_shutdown = True

### env variables ###

RSA_N = os.getenv("RSA_N")
RSA_D = os.getenv("RSA_D")
DISCORD_TOKEN = os.getenv("DISCORD_TOKEN")
LLM_TOKEN = os.getenv("LLM_TOKEN")
WEATHER_TOKEN = os.getenv("WEATHER_TOKEN")

if RSA_N is None or RSA_D is None or DISCORD_TOKEN is None or LLM_TOKEN is None or WEATHER_TOKEN is None:
    log_server(f"No env variables set ({', '.join([name for name, var in {'RSA_N': RSA_N, 'RSA_D': RSA_D, 'DISCORD_TOKEN': DISCORD_TOKEN, 'LLM_TOKEN': LLM_TOKEN, 'WEATHER_TOKEN': WEATHER_TOKEN}.items() if var is None])})")
    shutdown()
    quit()

n_len = len(RSA_N)

RSA_N = int(RSA_N)
RSA_D = int(RSA_D)

### turbowarp connection ###

response_manager = utilities.RequestManager()

def create_on_set(id):
    def on_set(e):
        if ("TO SERVER " in e.var):
            cloud_value = e.value
            old_response = response_manager.check(cloud_value)
            if old_response:
                var_queue.append((id, old_response))
                return
            if old_response == False:
                return
            try:
                code = ""
                for i in range(0, len(cloud_value), n_len):
                    code += str(pow(int(cloud_value[i:i+n_len]), RSA_D, RSA_N))[1:]
                values = encoder.decode(code)
                if len(values) < 5: return
                RequestID = values[0]
                AppID = values[1]
                Timestamp = values[2]
                try:
                    Timestamp = float(Timestamp)
                except ValueError:
                    return
                if abs(utilities.get_second_diff(Timestamp)) > 30:
                    return
                one_time_pad = int(values[3])
                parameters = values[4:]
                header = [f"@{AppID}:{RequestID}"]

                func = methodes.get(AppID)
                if func:
                    try:
                        result = func(*parameters)
                        status = 1
                    except (ReturnError, TypeError) as e:
                        result = list(e.args)
                        if len(result) == 0: result = ["error"]
                        status = 0
                else:
                    result = [f"invalid AppID {AppID}"]
                    status = 0
                
                meta_data = [utilities.get_days_since_2000(), status]
                encoded_result = []
                for element in meta_data + result:
                    code, one_time_pad = encoder.encode_one_time_pad(element, one_time_pad)
                    encoded_result.append(code)
                encoded = encoder.encode(header + encoded_result)
                encoded += "." + str(pow(utilities.hash(encoded), RSA_D, RSA_N))
                var_queue.append((id, encoded))
                response_manager.set(cloud_value, encoded)
                
            except Exception as e:
                error_server()
                # stop_event.set() # Stops the server if an error occurred
    return on_set

def create_on_reconnect(id):
    def on_reconnect():
        log_server(f"turbowarp reconnect: {id}")
    return on_reconnect

def create_on_ready(id):
    def on_ready():
        log_server(f"turbowarp is ready: {id}")
    return on_ready

cloud = {}
events = {}

def add_project(id):
    log_server(f"turbowarp add: {id}")
    cloud[id] = scratchattach.get_tw_cloud(id, purpose="Red OS 10", contact="https://scratch.mit.edu/users/KROKOBIL")
    events[id] = cloud[id].events()
    events[id].event(create_on_ready(id))
    events[id].event(create_on_reconnect(id))
    events[id].event(create_on_set(id))
    events[id].running = True
    events[id]._thread = threading.Thread(target=events[id]._updater, args=(), daemon=True)
    events[id]._thread.start()

def remove_project(id):
    log_server(f"turbowarp remove: {id}")
    events[id].stop()
    cloud[id].disconnect()
    del events[id]
    del cloud[id]

general = utilities.Storage("saves/general.json")
if general.get("projects") is None:
    general["projects"] = []
for id, _ in general["projects"]:
    add_project(id)

### discord connection ###

intents = discord.Intents.default()
intents.message_content = True

discord_client = commands.Bot(command_prefix="/", intents=intents)
discord_tree = discord_client.tree

bot_loop = asyncio.new_event_loop()

CHANNEL_ID = 1358447901365501962
ADMIN_IDS = [1140159421557780510, 1099139930648752138, 993149349058072607]

@discord_client.event
async def on_ready():
    try:
        await discord_tree.sync()
    except Exception as e:
        log_server(f"Could not sync command tree: {e}")
    log_server(f'discord is ready')

@discord_client.event
async def on_message(message: discord.Message):
    global discord_messages
    if message.author == discord_client.user:
        return
    
    # response to question
    if message.reference and str(message.reference.message_id) in discord_messages:
        if utilities.is_profane(message.content):
            await message.add_reaction("❌")
            return
        discord_message = discord_messages[str(message.reference.message_id)]
        discord_message["responses"][str(message.id)] = {"username": message.author.display_name, "text": message.content}
        user_data = get_user_data(discord_message["username"])
        messages: list = user_data.get("messages", [])
        messages.append([utilities.get_days_since_2000(), "discord", str(message.reference.message_id), str(message.id)])
        user_data["messages"] = messages
        await message.add_reaction("✅")

@discord_client.event
async def on_message_edit(before: discord.Message, after: discord.Message):
    global discord_messages
    for data in discord_messages.values():
        if "responses" in data:
            for id in data["responses"].keys():
                if str(id) == str(before.id):
                    if utilities.is_profane(after.content):
                        await after.add_reaction("❌")
                        return
                    response = data["responses"][str(id)]
                    if not response.get("original"):
                        response["original"] = []
                    response["original"].append(response["text"])
                    response["text"] = after.content
                    await after.add_reaction("🖋")
                    return

async def unsecure(interaction: Interaction) -> bool:
    if interaction.channel.id != CHANNEL_ID and not interaction.user.id in ADMIN_IDS:
        await interaction.response.send_message(f"for safety reasons you can only use this command here: <#{CHANNEL_ID}>")
        return True
    return False

async def admin(interaction: Interaction) -> bool:
    if not interaction.user.id in ADMIN_IDS:
        await interaction.response.send_message(f"for safety reasons only the admin can use this command: {', '.join(['<@' + str(id) + '>' for id in ADMIN_IDS])}")
        return True
    return False

@discord_tree.command(name="help", description="Displays help message")
async def help_command(interaction: Interaction):
    await interaction.response.send_message(
        "**Available Commands:**\n"
        "* `/help` – Display this help message\n"
        "* `/ping <message>` – Echo back your message\n"
        "* `/stats` – Show the number of registered users\n"
        "* `/project-get` – List all connected projects\n"
        "* `/project-add <project-id>` – Connect a new project with the given ID\n"
        "* `/project-remove <project-id>` – Remove a project\n"
        "* `/project-lock <project-id>` – Lock the project, so it cannot be removed. Only use this command for the official project.\n"
        "* `/music <song-name>` (append mp3 file) – Split the mp3 file in small parts\n"

        "**Admin Commands:**\n"
        "* `/project-unlock <project-id>` – Unlock the project\n"
        "* `/shutdown` – Shut down the server\n"
        "* `/restart` – Restart the server\n"
        "* `/admin <username>` – Gives the user admin rights in the project\n"
        "* `/admin-remove <username>` – Removes admin rights in the project\n"
    )

@discord_tree.command(name="ping", description="Echo back your message")
async def command_ping(interaction: Interaction, message: str):
    await interaction.response.send_message(message)

@discord_tree.command(name="stats", description="Show the number of registered users")
async def command_stats(interaction: Interaction):
    await interaction.response.send_message(f"users: {len(users)}")

def get_projects_list():
    response = ""
    for id, locked in general["projects"]:
        if locked:
            response += f"* `{id}` 🔒\n"
        else:
            response += f"* `{id}`\n"
    if response == "":
        response = "*No projects connected*"
    return response

@discord_tree.command(name="project-get", description="List all connected projects")
async def command_project_get(interaction: Interaction):
    await interaction.response.send_message(get_projects_list())

@discord_tree.command(name="project-add", description="Connect a new project")
async def command_project_add(interaction: Interaction, project_id: str):
    if await unsecure(interaction): return
    for id, _ in general["projects"]:
        if id == project_id:
            await interaction.response.send_message(f"project with id `{project_id}` is already connected")
            return
    if len(general["projects"]) >= 10:
        await interaction.response.send_message(f"maximum number of projects is already reached: 10")
        return
    general["projects"].append((project_id, False))
    general.save()
    add_project(project_id)
    await interaction.response.send_message(f"added project with id `{project_id}`\n{get_projects_list()}")

@discord_tree.command(name="project-remove", description="Remove a project")
async def command_project_remove(interaction: Interaction, project_id: str):
    if await unsecure(interaction): return
    idx = 0
    for id, _ in general["projects"]:
        if id == project_id: break
        idx += 1
    else:
        await interaction.response.send_message(f"project with id `{project_id}` is not connected")
        return
    if general["projects"][idx][1]:
        await interaction.response.send_message(f"project with id `{project_id}` is locked")
        return
    remove_project(project_id)
    del general["projects"][idx]
    general.save()
    await interaction.response.send_message(f"removed project with id `{project_id}`\n{get_projects_list()}")

@discord_tree.command(name="project-lock", description="Lock the project, so it cannot be removed. Only use this command for the official project.")
async def command_project_lock(interaction: Interaction, project_id: str):
    if await unsecure(interaction): return
    idx = 0
    for id, _ in general["projects"]:
        if id == project_id: break
        idx += 1
    else:
        await interaction.response.send_message(f"project with id `{project_id}` is not connected")
        return
    general["projects"][idx] = (project_id, True)
    await interaction.response.send_message(f"locked project with id `{project_id}`\n{get_projects_list()}")

@discord_tree.command(name="project-unlock", description="Unlock the project, can only be used by admins!")
async def command_project_unlock(interaction: Interaction, project_id: str):
    if await admin(interaction): return
    idx = 0
    for id, _ in general["projects"]:
        if id == project_id: break
        idx += 1
    else:
        await interaction.response.send_message(f"project with id `{project_id}` is not connected")
        return
    general["projects"][idx] = (project_id, False)
    await interaction.response.send_message(f"unlocked project with id `{project_id}`\n{get_projects_list()}")

@discord_tree.command(name="shutdown", description="Shut down the server, can only be used by admins!")
async def command_shutdown(interaction: Interaction):
    if await admin(interaction): return
    await interaction.response.send_message("The server is now shutting down safely.")
    log_server("shut down by discord message")
    shutdown()

@discord_tree.command(name="restart", description="Restart the server, can only be used by admins!")
async def command_restart(interaction: Interaction):
    if await admin(interaction): return
    await interaction.response.send_message("The server is now restarting safely.")
    log_server("restart by discord message")
    restart()

@discord_tree.command(name="music", description="Split the mp3 file in small parts")
async def command_music(interaction: Interaction, song_name: str, song_file: Attachment):
    song_name = song_name.split(".")[0].lower().replace(" ", "-")
    if not song_file.filename.lower().endswith(".mp3"):
        await interaction.response.send_message("Please upload a .mp3 file", ephemeral=True)
        return
    await interaction.response.defer(thinking=True)
    save_path = os.path.join('music/songs', song_name + ".mp3")
    os.makedirs("music", exist_ok=True)
    os.makedirs("music/songs", exist_ok=True)
    data = await song_file.read()
    with open(save_path, 'wb') as f:
        f.write(data)
    log_server(f"saved: {save_path}")

    result = subprocess.run(
        [PYTHON_CMD, "music/music.py", song_name],
        capture_output=True,
        text=True,
        timeout=300
    )

    if result.returncode != 0:
        log_server("Error: " + result.stderr.strip())
        await interaction.edit_original_response(content = "Error: " + result.stderr.strip())
        return
    
    output = result.stdout.strip()

    await interaction.edit_original_response(content = f"Success:\n```\n{output}\n```", attachments=[discord.File(f"music/songs/{song_name}.zip")])

@discord_tree.command(name="admin", description="Gives the user admin rights in the project, can only be used by KROKOBIL!")
async def command_admin(interaction: Interaction, username: str):
    if await admin(interaction): return
    user_data = users.get(username.lower(), None)
    if not user_data:
        await interaction.response.send_message(f"user {username} does not exist")
    user_data["admin"] = True
    await interaction.response.send_message(f"add admin: {username}")

@discord_tree.command(name="admin-remove", description="Removes admin rights in the project, can only be used by KROKOBIL!")
async def command_admin_remove(interaction: Interaction, username: str):
    if await admin(interaction): return
    user_data = users.get(username.lower(), None)
    if not user_data:
        await interaction.response.send_message(f"user {username} does not exist")
    user_data["admin"] = False
    await interaction.response.send_message(f"remove admin: {username}")

def run_discord_bot():
    asyncio.set_event_loop(bot_loop)
    bot_loop.run_until_complete(discord_client.start(DISCORD_TOKEN))


def send_discord_message_from_user(username, text):
    if not discord_client.is_ready():
        log_server("Bot ist not ready yet")
        return
    
    async def send():
        channel = discord_client.get_channel(CHANNEL_ID) or await discord_client.fetch_channel(CHANNEL_ID)
        
        msg_text = f"{text}\n-# {username}"
        msg = await channel.send(msg_text)

        discord_messages[str(msg.id)] = {"username": username, "text": text, "responses": {}}
        return msg.id

    future = asyncio.run_coroutine_threadsafe(send(), bot_loop)
    return future.result()

def send_discord_message(text):
    if not discord_client.is_ready():
        log_server("Bot ist not ready yet")
        return
    
    async def send():
        channel = discord_client.get_channel(CHANNEL_ID) or await discord_client.fetch_channel(CHANNEL_ID)
        
        msg = await channel.send(text)

        return msg.id

    future = asyncio.run_coroutine_threadsafe(send(), bot_loop)
    return future.result()


discord_thread = threading.Thread(target=run_discord_bot, args=(), daemon=True)
discord_thread.start()

### llm connection ###

with open("llm-context.txt", "r") as file:
    context = file.read()

def get_version(command):
    try:
        result = subprocess.run([command, '--version'], capture_output=True, text=True)
        output = result.stdout.strip() or result.stderr.strip()
        version_str = output.split()[1]
        return tuple(map(int, version_str.split('.')))
    except Exception:
        return None

python_version = get_version("python")
python3_version = get_version("python3")

if not python_version and python3_version:
    PYTHON_CMD = "python3"
elif python_version and not python3_version:
    PYTHON_CMD = "python"
elif python_version and python3_version:
    PYTHON_CMD = "python3" if python3_version > python_version else "python"
else:
    log_server("no python cmd available")
    shutdown()
    quit()

llm_env = os.environ.copy()
llm_env["LLM_TOKEN"] = LLM_TOKEN

def send_llm_message(username, text, conversation_ids):
    try:
        if len(conversation_ids) > 5:
            conversation_ids = conversation_ids[-5:]
        conversation = [{"role": "system", "content": context}]
        for message_id in conversation_ids:
            message = llm_messages.get(str(message_id))
            if message:
                conversation.append({"role": "user", "content": message["text"]})
                conversation.append({"role": "assistant", "content": message["answer"]})
        conversation.append({"role": "user", "content": text})

        result = subprocess.run(
            [PYTHON_CMD, "llm_worker.py", json.dumps(conversation)],
            env=llm_env,
            capture_output=True,
            text=True,
            timeout=20
        )

        if result.returncode != 0:
            log_server("Error: " + result.stderr.strip())
            raise ReturnError("Error: " + result.stderr.strip())

        response = json.loads(result.stdout.strip())

        if response.get("error"):
            log_server(response)
            raise ReturnError("Error, probably rate limit exceeded")
        answer = response["choices"][0]["message"]["content"]
        id = response["id"]

        llm_messages[id] = {"username": username, "text": text, "answer": answer}

        return (id, answer)
    except subprocess.TimeoutExpired:
        raise ReturnError("Timeout")
    except json.JSONDecodeError:
        raise ReturnError("JSONDecodeError")

### cloud var loop ###

try:
    var_count = 0
    last_set = 0.0
    while not stop_event.is_set():
        if len(var_queue) > 0:
            if time() > last_set + 0.1:
                id, value = var_queue.pop(0)
                if id in cloud:
                    cloud[id].set_var(f"FROM SERVER {var_count + 1}", value)
                last_set = time()
                var_count = (var_count + 1) % 4
        sleep(0.1)
except Exception as e:
    error_server()
finally:
    shutdown()
