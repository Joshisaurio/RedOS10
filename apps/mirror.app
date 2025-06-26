def init() {
    global window = window()
    window.center()
    window.mode = "camera"

    global shutter = container()
    shutter.fill()
    shutter.margin(0)
    window.add(shutter)

    global button = costume("other//camera-button")
    button.marginRight = 20
    button.size(50)
    button.scale = 3
    button.onClick = "take_photo()"
    button.theme = 1
    window.add(button)
}

def frame() {
    
}

def take_photo() {
    os.print("photo")
}