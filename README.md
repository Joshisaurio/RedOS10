# Red OS 10

This is the GitHub Repo where all changes of Red OS 10 will be released.

# Cloud

## Scratch

Load [this project](Red%20OS%2010%20Cloud.sb3) into the [turbowarp editor](https://turbowarp.org/editor) and copy the *app_base* sprite.
The **cloud.Request** block sends a request to the server and waits for an answer. It has three inputs:
- **AppID**: This is the name of your app. If your app needs multiple requests you can name it like `app.request`.
- **text**: This are the parameters you send to the server. You can separate paramters with `§`.
- **id (random)**: This is used to match the response from the server to your request. You should leave the random block in there.

The response from the server is saved to the **cloud.Answers** list.

The request tries to send three times with a delay of 3 seconds. Usually the server responds in around 0.5 seconds.

## Python

Basic methode:
```
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

Also, use a custom project id. In the *(☁ Variables)* sprite you have to set `project id` and in the python code `PROJECT_ID` to the same value (this can also be a string). If you don't do this there might be interference with the actual project.
