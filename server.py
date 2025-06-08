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
import asyncio
from datetime import datetime, timedelta, timezone
import json
import math
import subprocess
import aiohttp

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
    users[username.lower()] = {"username": user.username, "password": password_hash, "created": utilities.get_now_str(), "last_login": utilities.get_now_str()}
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
        user_data["settings"][args[i]] = args[i+1]
        i += 2
    return [username]

def get_settings(user_data: dict) -> list:
    settings = []
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
    username = username.lower()
    user_data = login(username, password)
    check_verified(user_data)
    check_ban(user_data)
    if utilities.is_profane(text):
        log_server(f"Profane message to discord by {user_data['username']}: {text}")
        user_data["ban"] = (datetime.now(timezone.utc) + timedelta(minutes=10)).replace(microsecond=0).strftime(utilities.FORMAT)
        user_data["ban_reason"] = "Profane message to discord"
        raise ReturnError("profane")
    message_id = send_discord_message(user_data["username"], text)
    discord = user_data.get("discord")
    if discord is None:
        user_data["discord"] = []
        discord = user_data["discord"]
    discord.append(message_id)
    return app_discord_list(username, password)

@methode("discord.list")
def app_discord_list(username: str, password: str) -> list:
    username = username.lower()
    user_data = login(username, password)
    discord = user_data.get("discord", [])
    discord_list = []
    for message_id in discord:
        discord_list.append(message_id)
        discord_list.append(discord_messages.get(str(message_id), {}).get("text", "None"))
    return discord_list

@methode("sly.search")
def app_sly_search(text):
    // code goes here :)
    return [text]

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

if RSA_N is None or RSA_D is None or DISCORD_TOKEN is None:
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

discord_client = discord.Client(intents=intents)

bot_loop = asyncio.new_event_loop()

CHANNEL_ID = 1358447901365501962
ADMIN_ID = 1140159421557780510

@discord_client.event
async def on_ready():
    log_server(f'discord is ready')

@discord_client.event
async def on_message(message: discord.Message):
    global discord_messages
    if message.author == discord_client.user:
        return
    
    # commands
    async def respond(text: str, file: discord.File = None):
        await message.channel.send(text, reference=message, mention_author=False, file=file)
    
    async def unsecure() -> bool:
        if message.channel.id != CHANNEL_ID and message.author.id != ADMIN_ID:
            await respond(f"for safety reasons you can only use this command here: <#{CHANNEL_ID}>")
            return True
        return False
    
    async def admin() -> bool:
        if message.author.id != ADMIN_ID:
            await respond(f"for safety reasons only the admin can use this command: <@{ADMIN_ID}>")
            return True
        return False
    
    if len(message.content) >= 2 and message.content[0] == "$":
        try:
            split = message.content[1:].split()
            match split[0]:
                case "help":
                    await respond(
                        "**Available Commands:**\n"
                        "* `$help` – Displays this help message\n"
                        "* `$ping <message>` – Echoes back your message\n"
                        "* `$stats` – Shows the number of registered users\n"
                        "* `$project get` – Lists all connected projects\n"
                        "* `$project add <project-id>` – Connects a new project with the given ID\n"
                        "* `$project remove <project-id>` – Removes the project\n"
                        "* `$project lock <project-id>` – Locks the project, so it cannot be removed. Only use this command for the official project. A lock can only be removed by KROKOBIL!\n"
                        "* `$music <song-name>` (append mp3 file) – Split the mp3 file in small parts\n"
                    )
                case "ping":
                    await respond(" ".join(split))
                case "stats":
                    await respond(f"users: {len(users)}")
                case "project" | "projects":
                    match split[1]:
                        case "get":
                            response = ""
                            for id, locked in general["projects"]:
                                if locked:
                                    response += f"* `{id}` 🔒\n"
                                else:
                                    response += f"* `{id}`\n"
                            if response == "":
                                await respond("*No projects connected*")
                            else:
                                await respond(response)
                        case "add":
                            if await unsecure(): return
                            for id, _ in general["projects"]:
                                if id == split[2]:
                                    await respond(f"project with id `{split[2]}` is already connected")
                                    return
                            if len(general["projects"]) >= 10:
                                await respond(f"maximum number of projects is already reached: 10")
                                return
                            general["projects"].append((split[2], False))
                            general.save()
                            add_project(split[2])
                            await respond(f"added project with id `{split[2]}`")
                        case "remove":
                            if await unsecure(): return
                            idx = 0
                            for id, _ in general["projects"]:
                                if id == split[2]: break
                                idx += 1
                            else:
                                await respond(f"project with id `{split[2]}` is not connected")
                                return
                            if general["projects"][idx][1]:
                                await respond(f"project with id `{split[2]}` is locked")
                                return
                            remove_project(split[2])
                            del general["projects"][idx]
                            general.save()
                            await respond(f"removed project with id `{split[2]}`")
                        case "lock":
                            if await unsecure(): return
                            idx = 0
                            for id, _ in general["projects"]:
                                if id == split[2]: break
                                idx += 1
                            else:
                                await respond(f"project with id `{split[2]}` is not connected")
                                return
                            general["projects"][idx] = (split[2], True)
                            await respond(f"locked project with id `{split[2]}`")
                        case "unlock":
                            if await admin(): return
                            idx = 0
                            for id, _ in general["projects"]:
                                if id == split[2]: break
                                idx += 1
                            else:
                                await respond(f"project with id `{split[2]}` is not connected")
                                return
                            general["projects"][idx] = (split[2], False)
                            await respond(f"unlocked project with id `{split[2]}`")

                case "shutdown":
                    if await admin(): return
                    await respond("The server is now shutting down safely.")
                    log_server("shut down by discord message")
                    shutdown()
                case "restart":
                    if await admin(): return
                    await respond("The server is now restarting safely.")
                    log_server("restart by discord message")
                    restart()
                
                case "music" | "song":
                    song_name = split[1].split(".")[0].lower().replace(" ", "-")
                    if len(message.attachments) == 0:
                        await respond(f"Please append mp3 file")
                        return
                    attachment = message.attachments[0]
                    save_path = os.path.join('music/songs', song_name + ".mp3")
                    os.makedirs("music", exist_ok=True)
                    os.makedirs("music/songs", exist_ok=True)
                    async with aiohttp.ClientSession() as session:
                        async with session.get(attachment.url) as resp:
                            if resp.status == 200:
                                with open(save_path, 'wb') as f:
                                    f.write(await resp.read())
                                log_server(f"saved: {save_path}")
                            else:
                                log_server(f"download failed: {resp.status}")
                    await respond(f"Processing {song_name} ...")

                    result = subprocess.run(
                        [PYTHON_CMD, "music/music.py", song_name],
                        capture_output=True,
                        text=True,
                        timeout=300
                    )

                    if result.returncode != 0:
                        log_server("Error: " + result.stderr.strip())
                        await respond("Error: " + result.stderr.strip())
                        return
                    
                    output = result.stdout.strip()

                    await respond(f"Success:\n```\n{output}\n```", discord.File(f"music/songs/{song_name}.zip"))
                
        except IndexError:
            await respond("missing arguments")

    # response to question
    if message.reference and str(message.reference.message_id) in discord_messages:
        if utilities.is_profane(message.content):
            await message.add_reaction("❌")
            return
        discord_messages[str(message.reference.message_id)]["responses"][str(message.id)] = {"username": message.author.display_name, "text": message.content}
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

def run_discord_bot():
    asyncio.set_event_loop(bot_loop)
    bot_loop.run_until_complete(discord_client.start(DISCORD_TOKEN))


def send_discord_message(username, text):
    if not discord_client.is_ready():
        log_server("Bot ist noch nicht bereit!")
        return
    
    async def send():
        channel = discord_client.get_channel(CHANNEL_ID) or await discord_client.fetch_channel(CHANNEL_ID)
        
        msg_text = f"{text}\n-# {username}"
        msg = await channel.send(msg_text)

        discord_messages[str(msg.id)] = {"username": username, "text": text, "responses": {}}
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
