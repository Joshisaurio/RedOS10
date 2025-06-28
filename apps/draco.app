def init() {
    global window = window(212, 276)
    window.pos(-494, -138)

    global chat = vScrollContainer()
    chat.margin(10)
    chat.marginBottom = 35

    draco = bubble("Hello there! I’m Draco, RedOS’s virtual assistant. How can I help you today?", 0)
    chat.add(draco)

    window.add(chat)

    bottom = container()
    bottom.height = "shrink"
    bottom.margin(5)
    bottom.marginTop = ""
    bottom.theme = 0

    button = container()
    button.margin(5)
    button.marginRight = ""
    button.width = "shrink"
    button.height = 16.5
    button.onClick = "mode()"
    button.theme = 0.2

    global buttonLabel = label("Draco", 8, 0.5)
    buttonLabel.width = 30
    buttonLabel.marginTop = 2
    buttonLabel.marginBottom = 0

    button.add(buttonLabel)
    bottom.add(button)

    global input = input()
    input.margin(5)
    input.marginRight = 25
    input.marginLeft = 40
    input.onEnter = "send()"
    input.theme = 0.1
    bottom.add(input)

    send = costume("other//send")
    send.size(15)
    send.margin(5)
    send.marginLeft = ""
    send.onClick = "send()"
    bottom.add(send)

    window.add(bottom)

    global turn = "user"
    global first_llm = true
}

def bubble(text, dir) {
    box = container()
    box.height = "shrink"
    box.margin(5)
    if (dir == 0) {
        box.marginRight = 50
    } else {
        box.marginLeft = 50
    }
    box.theme = 0

    global last_bubble_label = label(text, 10, dir, 1)
    last_bubble_label.margin(5)
    box.add(last_bubble_label)
    return box
}

def send() {
    if (turn != "user") {return}
    if (input.text == "") {return}
    user = bubble(input.text, 1)
    chat.add(user)
    if (buttonLabel.text == "LLM") {
        if (first_llm) {
            draco = bubble("You are now talking to a machine learning model that can make mistakes. Your messages might get stored on the server.", 0)
            chat.add(draco)
        }
    }
    draco = bubble("\l", 0)
    chat.add(draco)
    chat.scrollDown()
    
    if (buttonLabel.text == "Draco") {
        os.ask_draco(input.text, "answer")
    } elif (buttonLabel.text == "LLM") {
        os.ask_llm(input.text, "answer", first_llm)
        first_llm = false
    } else {
        return
    }

    turn = "draco"
    input.text = ""
}

def answer(response) {
    last_bubble_label.text = response
    chat.scrollDown()
    turn = "user"
    focus()
}

def mode() {
    if (buttonLabel.text == "Draco") {
        buttonLabel.text = "LLM"
    } elif (buttonLabel.text == "LLM") {
        buttonLabel.text = "Draco"
    }
    focus()
}

def focus() {
    input.focus()
}
