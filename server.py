import scratchattach as scratchattach
import encoder as encoder
import utilities
from time import time, sleep
import threading
import os
import traceback
import requests
from io import BytesIO
from PIL import Image
import random
import string
import bcrypt
import discord
import asyncio
from datetime import datetime, timedelta
import json
import math
import subprocess

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

PROJECT_ID = "1153014815"

VERIFICATION_ID = "1153014815"
verification_project: scratchattach.Project = utilities.dont_print(scratchattach.get_project, VERIFICATION_ID)

cloud = scratchattach.get_tw_cloud(PROJECT_ID, purpose="Red OS 10", contact="https://scratch.mit.edu/users/KROKOBIL")
events = cloud.events()

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
    is_correct = bcrypt.checkpw(password.encode(), user_password.encode())
    if not is_correct:
        raise ReturnError(f"wrong password")
    return user_data

def check_verified(user_data: dict) -> None:
    if not user_data.get("verified"):
        raise ReturnError(f"user '{user_data['username']}' is not verified")

def check_ban(user_data: dict) -> None:
    if user_data.get("ban"):
        last_ban = datetime.strptime(user_data["ban"], utilities.FORMAT) - datetime.now()
        if last_ban > timedelta():
            raise ReturnError(f"banned for {math.ceil(last_ban.seconds/60)} minutes")

@methode("system.login")
def app_system_login(username: str, password: str) -> list:
    user_data = login(username, password)
    return [user_data["username"], user_data.get("verified", False)]

@methode("system.signup")
def app_system_signup(username: str, password: str) -> list:
    if len(password) < 3:
        raise ReturnError(f"password has to have at least 3 digits")
    user = get_scratch_user(username)
    user_data = users.get(username.lower())
    if user_data: raise ReturnError("user already exists", user_data["username"])

    password_hash = bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()
    users[username] = {"username": user.username, "password": password_hash, "created": utilities.get_now_str()}
    return [user.username]

@methode("system.reset_password")
def app_system_reset_password(username: str, password: str) -> list:
    if len(password) < 3:
        raise ReturnError(f"password has to have at least 3 digits")
    user = get_scratch_user(username)
    user_data = get_user_data(username)
    
    password_hash = bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()
    user_data["password"] = password_hash
    return [user.username]

@methode("system.get_verification")
def app_system_get_verification(username: str) -> list:
    user = get_scratch_user(username)
    user_data = get_user_data(username)
    
    verification_code = ''.join(random.choices(string.ascii_letters + string.digits, k=40))
    user_data["verification_code"] = verification_code
    return [user.username, verification_project.url, verification_code]

@methode("system.check_verification")
def app_system_check_verification(username: str) -> list:
    user_data = get_user_data(username)
    verification_code = user_data.get("verification_code")
    if not verification_code:
        raise ReturnError(f"user '{username}' does not have a verification code")
    has_commented = list(filter(lambda x : x.author_name.lower() == user_data["username"].lower() and x.content == verification_code, verification_project.comments())) != []
    if not has_commented:
        raise ReturnError(f"user '{username}' didn't comment the correct code")
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
    username = username.lower()
    cache_result = pfp_cache.get(username)
    if cache_result:
        return [encoder.Number(cache_result)]
    user = get_scratch_user(username)
    
    size: int = 90

    url = f"https://uploads.scratch.mit.edu/get_image/user/{user.id}_{size}x{size}.png"
    # url = user.icon_url
    response = requests.get(url)

    image = Image.open(BytesIO(response.content))
    image = image.resize((size, size), Image.LANCZOS)
    image = image.convert("RGBA")
    background = Image.new("RGB", image.size, (255, 255, 255))
    background.paste(image, mask=image.split()[3])
    image = background

    pixel_list = list(image.getdata())

    response = ""
    last_pixel = None
    count = 0
    for pixel in pixel_list:
        color_str = ""
        for color in (pixel[0], pixel[1], pixel[2]):
            color_str += "{:02d}".format(int(round(float(color)/255*99)))
        if color_str == last_pixel and count < 99:
            count += 1
        else:
            if last_pixel != None:
                response += "{:02d}".format(count) + last_pixel
            last_pixel = color_str
            count = 0
    response += "{:02d}".format(count) + color_str
    pfp_cache[username.lower()] = response
    return [encoder.Number(response)]

request_count = 0
@methode("weather")
def app_weather(city_name: str) -> list:
    global request_count
    api_key = "fb75fdcd2acd464022981570513a2c3c"
    base_url = "http://api.openweathermap.org/data/2.5/weather"

    complete_url = f"{base_url}?appid={api_key}&q={city_name}&units=metric"
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

storage = utilities.Storage("saves/storage.json")
@methode("storage.set")
def app_storage_set(key: str, value: str) -> list:
    storage[key.lower()] = value
    return []

@methode("storage.get")
def app_storage_get(key: str) -> list:
    return [storage.get(key.lower(), "")]

discord_messages = utilities.Storage("saves/discord.json", 5)
@methode("discord.post")
def app_discord_post(username: str, password: str, text: str) -> list:
    username = username.lower()
    user_data = login(username, password)
    check_verified(user_data)
    check_ban(user_data)
    if utilities.is_profane(text):
        log_server(f"Profane message to discord by {user_data['username']}: {text}")
        user_data["ban"] = (datetime.now() + timedelta(minutes=10)).strftime(utilities.FORMAT)
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

llm_messages = utilities.Storage("saves/llm.json", 5)
@methode("llm.post")
def app_llm_post(username: str, password: str, text: str) -> list:
    username = username.lower()
    user_data = login(username, password)
    check_ban(user_data)
    if utilities.is_profane(text):
        log_server(f"Profane message to llm by {user_data['username']}: {text}")
        user_data["ban"] = (datetime.now() + timedelta(minutes=10)).strftime(utilities.FORMAT)
        user_data["ban_reason"] = "Profane message to llm"
        raise ReturnError("profane")
    message_id, answer = send_llm_message(user_data["username"], text)
    llm = user_data.get("llm")
    if llm is None:
        user_data["llm"] = []
        llm = user_data["llm"]
    llm.append(message_id)
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

def shutdown():
    global is_shutdown
    if is_shutdown: return
    events.stop()
    cloud.disconnect()
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

@events.event
def on_set(e):
    if ("TO SERVER " in e.var):
        cloud_value = e.value
        old_response = response_manager.check(cloud_value)
        if old_response:
            var_queue.append(old_response)
            return
        if old_response == False:
            return
        response = []
        try:
            code = ""
            for i in range(0, len(cloud_value), n_len):
                code += str(pow(int(cloud_value[i:i+n_len]), RSA_D, RSA_N))[1:]
            values = encoder.decode(code)
            if len(values) < 4: return
            RequestID = values[0]
            AppID = values[1]
            Timestamp = values[2]
            try:
                Timestamp = float(Timestamp)
            except ValueError:
                return
            if abs(utilities.get_second_diff(Timestamp)) > 15: # 15 seconds
                return
            OneTimePad = values[3]
            parameters = values[4:]
            response.append(f"@{AppID}:{RequestID}")

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
            
            response.append(utilities.get_days_since_2000())
            response.append(status)
            result_encoded_otp = [encoder.encode_one_time_pad(element, OneTimePad) for element in result]
            response.extend(result_encoded_otp)
            encoded = encoder.encode(response)
            encoded += "." + str(pow(utilities.hash(encoded), RSA_D, RSA_N))
            var_queue.append(encoded)
            response_manager.set(cloud_value, encoded)
            
        except Exception as e:
            error_server()
            # stop_event.set() # Stops the server if an error occurred

@events.event
def on_reconnect():
    log_server("turbowarp reconnect")

@events.event
def on_ready():
    log_server("turbowarp is ready")

events.running = True
events._thread = threading.Thread(target=events._updater, args=(), daemon=True)
events._thread.start()

### discord connection ###

intents = discord.Intents.default()
intents.message_content = True

discord_client = discord.Client(intents=intents)

bot_loop = asyncio.new_event_loop()

CHANNEL_ID = 1355881514772070520

@discord_client.event
async def on_ready():
    log_server(f'discord is ready')

@discord_client.event
async def on_message(message: discord.Message):
    global discord_messages
    if message.author == discord_client.user:
        return
    
    # commands
    async def respond(text: str):
        await message.channel.send(text, reference=message, mention_author=False)
    
    if len(message.content) >= 2 and message.content[0] == "$":
        split = message.content[1:].split()
        match split[0]:
            case "ping":
                await respond(" ".join(split))
            case "stats":
                await respond(f"users: {len(users)}")

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
        
        msg_text = f"*{username}:*\n{text}"
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
llm_env["LLM_CONTEXT"] = context

def send_llm_message(username, text):
    try:
        result = subprocess.run(
            [PYTHON_CMD, "llm_worker.py", text],
            env=llm_env,
            capture_output=True,
            text=True,
            timeout=20
        )

        if result.returncode != 0:
            log_server("Error: " + result.stderr.strip())
            raise ReturnError("Error: " + result.stderr.strip())

        response = json.loads(result.stdout.strip())

        answer = response["choices"][0]["message"]["content"]
        id = response["id"]

        llm_messages[id] = {"username": username, "text": text, "responses": {id: {"username": "[LLM]", "text": answer}}}

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
                cloud.set_var(f"FROM SERVER {var_count + 1}", var_queue.pop(0))
                last_set = time()
                var_count = (var_count + 1) % 4
        sleep(0.1)
except Exception as e:
    error_server()
finally:
    shutdown()
