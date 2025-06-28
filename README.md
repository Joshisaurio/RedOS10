# Red OS 10

This is the GitHub Repo where all changes of Red OS 10 will be released.

# Coding Language

[Coding Language](apps/README.md)

# Cloud

## Scratch

Load [this project](Red%20OS%2010%20Cloud.sb3) into the [turbowarp editor](https://turbowarp.org/editor) and copy the *app_base* sprite.
The **cloud.Request** block sends a request to the server and waits for an answer. It has three inputs:
- **AppID**: This is the name of your app. If your app needs multiple requests you can name it like `app.request`.
- **text**: This are the parameters you send to the server. You can separate paramters with `§`.
- **id (random)**: This is used to match the response from the server to your request. You should leave the random block in there.

The response from the server is saved to the **cloud.Answers** list.

The request tries to send five times with a delay of 3 seconds. Usually the server responds in around 0.5 seconds.

## Python

Basic methode:
``` python
@methode("base")
def app_base(text: str) -> list:
    return [text]
```

The decorator `@methode("app.request")` tells the server that this function can be called with the **AppID** `app.request`. You have to use the same name as in Scratch. How you name the function doesn't matter.

If you separate the parameters with `§`, you also have to add these parameters to the function.

The function should return a list of objects that can be turned into strings. You can also use the `encoder.Number` class if you want to send only digits (e.g. savecodes, imagaes, ...):
`encoder.Number("013764737016234710")`

If you want to print anything, use the `log_server()` function. This adds a timecode (UTC) and has an option to log to the `logs/server.log` file if `LOG_TO_FILE` is `True`.

## Testing

The server will probably running constantly and it won't be updated very often. For testing you have to run *server.py* on your own computer.

You should test your app in the [turbowarp editor](https://turbowarp.org/editor). You need the [(☁ Variables)](CloudVariables.sprite3) sprite for turbowarp editor cloud variable connection.
**Before you upload the project to Scratch, remove this sprite!**

In the *(☁ Variables)* sprite you have to set `project id` to an id that the server is connected to. You can get a list of all conencted projects by posting `$project get` in the support channel of our discord server.

## Storage

The server can store data to files using the `utilities.Storage` class. This class works like a normal `dict`, but it also saves the data to a file in specified time intervals:

``` python
data = utilities.Storage("saves/data.json", intervall_sec=10) # the second parameter is optional

# use like a normal dict
data["key"] = "value"
```

## Security

All requests from the project are encrypted meaning only the server can read them.
All responses from the server are encrypted with a short one time pad and the project can verify that they are from the server.
Every message also has a timestamp that is valid for 15 seconds.

Passwords are stored as hashes.

The rsa encryption keys can be generated with [rsa.py](rsa.py).

## LLM Chat Bot

The server can send messages to a large language model (llm). This service is totally free and has no request limit.

When a user asks this chat bot a question, it will also get some general information stored in [llm-context.txt](llm-context.txt).

If the question is profane, the user is banned for 10 minutes from asking llm or discord.

## Discord Bot

The server has a connection to discord and can send and receive messages.

To send a message from the project to discord, the user needs a verified account. The server posts the question in a channel. If someone responds to that message, it will be sent back to the user (not yet implemented).

The server reacts with:
- ✅ if it received your response
- 🖋 if you edited the response
- ❌ if your answer is profane

If the question is profane, the user is banned for 10 minutes from asking llm or discord.

The bot has also some basic commands:
* `/help` – Display this help message
* `/ping <message>` – Echo back your message
* `/stats` – Show the number of registered users
* `/project-get` – List all connected projects
* `/project-add <project-id>` – Connect a new project with the given ID
* `/project-remove <project-id>` – Remove a project
* `/project-lock <project-id>` – Lock the project, so it cannot be removed. Only use this command for the official project. A lock can only be removed by KROKOBIL!
* `/music <song-name>` (append mp3 file) – Split the mp3 file in small parts

You can use some commands in a DM to the bot.

## Env Variables

There are some environment variables that have to be set before the server starts:
- `RSA_N`: part of the public and private key for rsa encryption
- `RSA_D`: part of the private key for rsa encryption
- `DISCORD_TOKEN`: token for the discord bot
- `LLM_TOKEN`: token for the chat bot api
- `WEATHER_TOKEN`: token for the weather api
