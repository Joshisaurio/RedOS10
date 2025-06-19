def init() {
    global window = window()
    window.center()
    window.mode = "camera"

    global warning = label("", 25)
    warning.margin(10)
    warning.marginBottom = ""
    window.add(warning)
}

def frame() {
    warning.text = "Please enable fullscreen"
    if (window.width >= 480) {
        if (window.height >= 335) {
            warning.text = ""
        }
    }
}