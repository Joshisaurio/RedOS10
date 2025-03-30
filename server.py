import scratchattach as scratchattach
import encoder as encoder
import utilities
from time import time, sleep
import threading
import os
import scratchattach.eventhandlers
import scratchattach.eventhandlers.cloud_events
import traceback
import requests
from io import BytesIO
from PIL import Image
import random
import string
import bcrypt

LOG_TO_FILE = True

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

os.chdir(os.path.dirname(os.path.abspath(__file__)))

methodes = {}
def methode(name):
    def decorator(func):
        global methodes
        methodes[name] = func
        return func
    return decorator


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

@methode("system.login")
def app_system_login(username: str, password: str) -> list:
    username = username.lower()
    user_data = users.get(username, None)
    if not user_data:
        return [f"user '{username}' does not exist"]
    user_password = user_data.get("password", None)
    if not user_password:
        return [f"user '{username}' does not have a password"]
    is_correct = bcrypt.checkpw(password.encode(), user_password.encode())
    if not is_correct:
        return [f"wrong password"]
    return [user_data["username"]]

@methode("system.signup")
def app_system_signup(username: str, password: str) -> list:
    if len(password) < 3:
        return [f"password has to have at least 3 digits"]
    username = username.lower()
    try:
        user: scratchattach.User = utilities.dont_print(scratchattach.get_user, username)
    except scratchattach.utils.exceptions.UserNotFound:
        return ["user not found"]
    user_data = users.get(username, None)
    if user_data: return ["user already exists", user_data["username"]]

    password_hash = bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()
    users[username] = {"username": user.username, "password": password_hash}
    return [user.username]

@methode("system.reset_password")
def app_system_reset_password(username: str, password: str) -> list:
    if len(password) < 3:
        return [f"password has to have at least 3 digits"]
    username = username.lower()
    try:
        user: scratchattach.User = utilities.dont_print(scratchattach.get_user, username)
    except scratchattach.utils.exceptions.UserNotFound:
        return ["user not found"]
    user_data = users.get(username, None)
    if not user_data:
        return ["user has no account"]
    
    password_hash = bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()
    users[username]["password"] = password_hash
    return [user.username]

@methode("system.get_verification")
def app_system_get_verification(username: str) -> list:
    username = username.lower()
    try:
        user: scratchattach.User = utilities.dont_print(scratchattach.get_user, username)
    except scratchattach.utils.exceptions.UserNotFound:
        return ["user not found"]
    user_data = users.get(username, None)
    if not user_data:
        return ["user has no account"]
    
    verification_code = ''.join(random.choices(string.ascii_letters + string.digits, k=40))
    users[username.lower()]["verification_code"] = verification_code
    return [user.username, verification_project.url, verification_code]

@methode("system.check_verification")
def app_system_checkverification(username: str) -> list:
    username = username.lower()
    user_data = users.get(username, None)
    if not user_data:
        return [f"user '{username}' does not exist"]
    verification_code = users[username].get("verification_code", None)
    if not verification_code:
        return [f"user '{username}' does not have a verification code"]
    has_commented = list(filter(lambda x : x.author_name.lower() == user_data["username"].lower() and x.content == verification_code, verification_project.comments())) != []
    if not has_commented:
        return [f"user '{username}' didn't comment the correct code"]
    return [username]

pfp_cache = {}
@methode("pfp")
def app_pfp(username: str) -> list:
    global pfp_cache
    cache_result = pfp_cache.get(username.lower(), None)
    if cache_result:
        return [encoder.Number(cache_result)]
    try:
        user: scratchattach.User = utilities.dont_print(scratchattach.get_user, username)
    except scratchattach.utils.exceptions.UserNotFound:
        return ["user not found"]
    
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
        if color_str == last_pixel and count < 10:
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
    api_key = "d850f7f52bf19300a9eb4b0aa6b80f0d"
    base_url = "http://api.openweathermap.org/data/2.5/weather?"

    complete_url = f"{base_url}appid={api_key}&q={city_name}"
    # complete_url = base_url + "appid=" + 'd850f7f52bf19300a9eb4b0aa6b80f0d' + "&q=" + city_name 
    request_count += 1
    response = requests.get(complete_url)
    answer: dict = response.json()

    match str(answer["cod"]):
        case "200": pass # OK
        case "404": return [answer.get("message", "404")]
        case _: raise ConnectionError(answer)

    current_temperature = answer["main"]["temp"]
    weather_description = answer["weather"][0]["description"]

    return [
        round(current_temperature-274.15,2),
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


########################################################


stop_event = threading.Event()

def shutdown() -> None:
    events.stop()
    cloud.disconnect()
    stop_event.set()
    log_server("saving...")
    utilities.save_all_storage_instances()
    log_server("server stopped")
    if LOG_TO_FILE:
        server_log_file.close()

n = os.getenv("RSA_N")
d = os.getenv("RSA_D")

if n is None or d is None:
    log_server("No env variables set (RSA_N, RSA_D)")
    shutdown()
    quit()

n_len = len(n)

n = int(n)
d = int(d)


first_message = True
first_message_time = None

@events.event
def on_set(e):
    global first_message, first_message_time
    if first_message:
        first_message_time = time()
        first_message = False
        return
    elif first_message_time:
        if time() - first_message_time < 0.1:
            return
        else:
            first_message_time = None
    if ("TO SERVER " in e.var):
        response = []
        try:
            code = ""
            for i in range(0, len(e.value), n_len):
                code += str(pow(int(e.value[i:i+n_len]), d, n))[1:]
            values = encoder.decode(code)
            if len(values) < 3: return
            RequestID = values[0]
            AppID = values[1]
            Timestamp = values[2]
            if abs(utilities.get_second_diff(Timestamp)) > 15: # 15 seconds
                return
            parameters = values[3:]
            response.append(f"@{AppID}:{RequestID}")
            func = methodes.get(AppID, None)
            if func:
                result = func(*parameters)
                response.append(utilities.get_days_since_2000())
                response.extend(result)
                encoded = encoder.encode(response)
                encoded += "." + str(pow(utilities.hash(encoded), d, n))
                var_queue.append(encoded)
            
        except Exception as e:
            error_server()
            # stop_event.set() # Stops the server if an error occurred

@events.event
def on_reconnect():
    log_server("reconnect")

@events.event
def on_ready():
    log_server("ready")

events.running = True
events._thread = threading.Thread(target=events._updater, args=(), daemon=True)
events._thread.start()

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
