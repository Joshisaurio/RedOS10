def init() {
    global window = window()
    window.center()

    tabs = tabs()
    tabs.fill()
    tabs.tab = 1

    // CLOCK
    tab1 = container()
    tabs.add(tab1, "Clock")

    title = label("Clock", 12)
    title.margin(8, "", "", 8)
    tab1.add(title)

    global time_label = label("", 16, 0.5)
    time_label.monospace = true
    time_label.margin("")
    time_label.marginBottom = 40
    tab1.add(time_label)

    clock_canvas = costume("#clock", 96)
    clock_canvas.margin(30, 0, 70)
    tab1.add(clock_canvas)

    time_mode = switch("Use 24-hour time")
    time_mode.margin(8)
    time_mode.marginTop = ""
    tab1.add(time_mode)
    
    // TIMER
    tab2 = container()
    tabs.add(tab2, "Timer")

    title = label("Timer", 12)
    title.margin(8, "", "", 8)
    tab2.add(title)
    
    global timer = 0
    global timer_is_running = false

    global timer_label = Label("00:00:00", 16, 0.5)
    timer_label.monospace = true
    timer_label.margin(0, "", 14)
    tab2.add(timer_label)

    global timer_canvas = costume("#timer", 112)
    timer_canvas.margin(28, 0, 48)
    tab2.add(timer_canvas)

    // Buttons
    buttons = hcontainer()
    buttons.margin("", 6, 6, 6)
    buttons.height = "shrink"

    global timer_button_toggle = button("Start", "timer_toggle")
    timer_button_toggle.margin(2)
    timer_button_toggle.theme = "#FF4060"
    buttons.add(timer_button_toggle)
    
    global timer_button_cancel = button("Cancel", "timer_cancel")
    timer_button_cancel.margin(2)
    buttons.add(timer_button_cancel)

    tab2.add(buttons)
    
    // STOPWATCH
    tab3 = container()
    tabs.add(tab3, "Stopwatch")
    
    title = label("Stopwatch", 12)
    title.margin(8, "", "", 8)
    tab3.add(title)
    
    global stopwatch = 0
    global stopwatch_is_running = false

    global stopwatch_label = label("00:00:00.00", 28, 0.5)
    stopwatch_label.monospace = true
    stopwatch_label.margin(28, 8, "")
    tab3.add(stopwatch_label)

    global laps = vScrollContainer()
    laps.margin(72, 8, 32)
    tab3.add(laps)

    global lapCount = 0

    // Buttons
    buttons = hcontainer()
    buttons.margin("", 6, 6, 6)
    buttons.height = "shrink"

    global stopwatch_button_toggle = button("Start", "stopwatch_toggle")
    stopwatch_button_toggle.margin(2)
    stopwatch_button_toggle.theme = "#FF4060"
    buttons.add(stopwatch_button_toggle)

    global stopwatch_button_lap = button("Lap", "stopwatch_lap")
    stopwatch_button_lap.margin(2)
    buttons.add(stopwatch_button_lap)
    
    global stopwatch_button_reset = button("Reset", "stopwatch_reset")
    stopwatch_button_reset.margin(2)
    buttons.add(stopwatch_button_reset)

    tab3.add(buttons)
    
    // WORLD CLOCK
    tab4 = container()
    tabs.add(tab4, "World Clock")

    title = label("World Clock", 12)
    title.margin(8, "", "", 8)
    tab4.add(title)
    
    
    window.add(tabs)
}

def frame() {
    time_label.text = os.time_seconds_str
    if (timer_is_running) {
        timer += os.delta
    }
    timer_label.text = time_to_format(timer)
    
    if (stopwatch_is_running) {
        stopwatch += os.delta
    }
    stopwatch_label.text = time_to_format(stopwatch)

    timer_canvas.data = timer
}

def time_to_format(time) {
    centiseconds = floor((time % 1) * 100)
    if (centiseconds < 10) {
        centiseconds = "0" + centiseconds
    }
    seconds = floor(time % 60)
    if (seconds < 10) {
        seconds = "0" + seconds
    }
    minutes = floor(time/60 % 60)
    if (minutes < 10) {
        minutes = "0" + minutes
    }
    format = minutes + ":" + seconds + ":" + centiseconds
    if (time >= 3600) {
        hours = floor(time/3600 % 60)
        format = hours + ":" + format
    }
    return format
    
}

def timer_toggle() {
    timer_is_running = !timer_is_running
    if (timer_is_running) {
        timer_button_toggle.text = "Pause"
    } else {
        timer_button_toggle.text = "Start"
    }
}

def timer_cancel() {
    timer_is_running = false
    timer = 0
    timer_button_toggle.text = "Start"
}

def stopwatch_toggle() {
    stopwatch_is_running = !stopwatch_is_running
    if (stopwatch_is_running) {
        stopwatch_button_toggle.text = "Pause"
    } else {
        stopwatch_button_toggle.text = "Start"
    }
}

def stopwatch_lap() {
    lapCount += 1
    lap = container()
    lap.height = 18

    lapCountLabel = label(lapCount)
    lapCountLabel.margin("", "", "", 4)
    lap.add(lapCountLabel)
    
    lapTimeLabel = label(stopwatch_label.text)
    lapTimeLabel.monospace = true
    lapTimeLabel.align = 1
    lapTimeLabel.margin("", 4, "", "")
    lap.add(lapTimeLabel)

    laps.add(lap)
    laps.scrollDown()
}

def stopwatch_reset() {
    stopwatch_is_running = false
    stopwatch = 0
    stopwatch_button_toggle.text = "Start"
    laps.delete_children()
}
