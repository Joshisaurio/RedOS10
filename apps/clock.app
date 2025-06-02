def init() {
    global window = window()
    window.center()

    tabs = tabs()
    tabs.fill()
    tabs.tab = 1


    tab1 = container()
    tabs.add(tab1, "Clock")

    title = label("Clock", 12)
    title.margin(8, "", "", 8)
    tab1.add(title)

    global time = Label("", 16, 0.5)
    time.margin("")
    time.marginBottom = 44
    tab1.add(time)

    time_mode = Label("Use 24-hour time", 8)
    time_mode.margin(8)
    time_mode.marginTop = ""
    tab1.add(time_mode)
    

    tab2 = container()
    tabs.add(tab2, "Timer")

    title = label("Timer", 12)
    title.margin(8, "", "", 8)
    tab2.add(title)
    
    buttons = hcontainer()
    buttons.margin("", 6, 6, 6)
    buttons.height = "shrink"

    global timer_button_start = button("Start", "timer_toggle")
    timer_button_start.margin(2)
    timer_button_start.theme = "#FF4060"
    buttons.add(timer_button_start)
    
    global timer_button_cancel = button("Cancel", "timer_cancel")
    timer_button_cancel.margin(2)
    buttons.add(timer_button_cancel)

    tab2.add(buttons)
    

    tab3 = container()
    tabs.add(tab3, "Stopwatch")
    
    title = label("Stopwatch", 12)
    title.margin(8, "", "", 8)
    tab3.add(title)
    
    buttons = hcontainer()
    buttons.margin("", 6, 6, 6)
    buttons.height = "shrink"

    global stopwatch_time = label("00:00:00.00", 28, 0.5)
    stopwatch_time.margin(28, 8, "")
    tab3.add(stopwatch_time)

    global laps = vScrollContainer()
    laps.margin(72, 8, 32)
    tab3.add(laps)

    global lapCount = 0

    global stopwatch_button_start = button("Start", "stopwatch_start")
    stopwatch_button_start.margin(2)
    stopwatch_button_start.theme = "#FF4060"
    buttons.add(stopwatch_button_start)

    global stopwatch_button_lap = button("Lap", "stopwatch_lap")
    stopwatch_button_lap.margin(2)
    buttons.add(stopwatch_button_lap)
    
    global stopwatch_button_reset = button("Reset", "stopwatch_reset")
    stopwatch_button_reset.margin(2)
    buttons.add(stopwatch_button_reset)

    tab3.add(buttons)
    

    tab4 = container()
    tabs.add(tab4, "World Clock")

    title = label("World Clock", 12)
    title.margin(8, "", "", 8)
    tab4.add(title)
    
    
    window.add(tabs)
}

def frame() {
    time.text = os.time_seconds_str
}

def timer_toggle() {
    os.print("timer_toggle")
}

def timer_cancel() {
    os.print("timer_cancel")
}

def stopwatch_start() {
    os.print("stopwatch_start")
}

def stopwatch_lap() {
    os.print("stopwatch_lap")
    lapCount += 1
    lap = container()
    lap.height = 18

    lapCountLabel = label(lapCount)
    lapCountLabel.margin("", "", "", 4)
    lap.add(lapCountLabel)
    
    lapTimeLabel = label(stopwatch_time.text)
    lapTimeLabel.align = 1
    lapTimeLabel.margin("", 4, "", "")
    lap.add(lapTimeLabel)

    laps.add(lap)
    laps.scrollDown()
}

def stopwatch_reset() {
    os.print("stopwatch_reset")
}
