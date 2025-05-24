def init() {
    global window = window()
    window.center()

    title = label("Clock", 20)
    title.margin(10)
    title.marginBottom = ""

    window.add(title)

    global time = Label("", 10)
    time.margin(50, 10, "")
    
    window.add(time)
    
    timezone = os.timezone
    if (timezone >= 0) {
        timezone = "+" + timezone
    }
    global timetone = Label("Timezone: UTC " + timezone, 10)
    timetone.margin(80, 10, "")
    
    window.add(timetone)
}

def frame() {
    time.text = "Time: " + os.hour + ":" + os.minute + ":" + os.second + "." + floor(os.millisecond/10)
}
