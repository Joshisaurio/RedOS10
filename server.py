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

LOG_TO_FILE = True

if LOG_TO_FILE:
    server_log_file = open("logs/server.log", "a")

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

pfp_cache = {}
@methode("pfp")
def app_pfp(username: str) -> list:
    global pfp_cache
    cache_result = pfp_cache.get(username.lower(), None)
    if cache_result:
        return [encoder.Number(cache_result)]
    try:
        user = utilities.dont_print(scratchattach.get_user, username)
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

storage: dict = {}
@methode("storage.set")
def app_storage_set(key: str, value: str) -> list:
    storage[key.lower()] = value
    return []

@methode("storage.get")
def app_storage_get(key: str) -> list:
    return [storage.get(key.lower(), "")]


########################################################


@events.event
def on_set(e):
    if ("TO SERVER " in e.var):
        response = []
        try:
            values = encoder.decode(e.value)
            if len(values) < 3: return
            RequestID = values[0]
            AppID = values[1]
            parameters = values[2:]
            response.append(f"@{AppID}:{RequestID}")
            func = methodes.get(AppID, None)
            if func:
                response.extend(func(*parameters))
            
        except Exception as e:
            error_server()
            # stop_event.set() # Stops the server if an error occurred 
        
        var_queue.append(encoder.encode(response))

@events.event
def on_reconnect():
    log_server("reconnect")

@events.event
def on_ready():
    log_server("ready")

stop_event = threading.Event()

events.running = True
events._thread = threading.Thread(target=events._updater, args=(), daemon=True)
events._thread.start()


def shutdown() -> None:
    events.stop()
    cloud.disconnect()
    stop_event.set()
    # log_server("saving...")
    log_server("server stopped")
    if LOG_TO_FILE:
        server_log_file.close()

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
