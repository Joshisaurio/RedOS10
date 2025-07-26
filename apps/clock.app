def init() {
    global city_names = list("Rome",             "Berlin",             "New York",        "London",        "Tokyo",            "Mexico City",       "Miami",           "Rio de Janeiro", "Cape Town",               "Mumbai",        "Cairo")
    global city_infos = list("Capital of Italy", "Capital of Germany", "City in the USA", "Capital of GB", "Capital of Japan", "Capital of Mexico", "City in Florida", "City in Brazil", "Capital of South Africa", "City in India", "Capital of Egypt")
    global city_utcs  = list(2,                  2,                    -4,                 1,               9,                 -6,                  -4,                -3,               2,                         5.5,             3)

    global window = window()
    window.minSize(300, 200)
    window.center()

    global tabs = tabs()
    tabs.fill()

    // CLOCK
    tab1 = container()
    tabs.add(tab1, "Clock")

    title = label("Clock", 12)
    title.margin(8, "", "", 8)
    tab1.add(title)

    global time_label = label("", 16, 0.5)
    time_label.margin("")
    time_label.marginBottom = 40
    tab1.add(time_label)

    clock_canvas = costume("#clock", 96)
    clock_canvas.margin(30, 0, 70)
    tab1.add(clock_canvas)

    global time_mode = switch("Use 24-hour time", "toggleFullHours()")
    time_mode.state = os.get_effect(4)
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
    global total_timer = 0
    global timer_is_running = false
    global timer_is_edit_mode = true

    global timer_inner = container()
    timer_inner.margin(28, "", 48)
    timer_inner.size(100)
    timer_inner.minSize(100)
    tab2.add(timer_inner)

    create_timer_input()

    global timer_canvas = costume("#timer", 112)
    timer_canvas.margin(28, 0, 48)
    tab2.add(timer_canvas)

    // Buttons
    buttons = hcontainer()
    buttons.margin("", 6, 6, 6)
    buttons.height = "shrink"

    global timer_button_toggle = button("Start", "timer_toggle()")
    timer_button_toggle.margin(2)
    timer_button_toggle.theme = "#FF4060"
    buttons.add(timer_button_toggle)
    
    global timer_button_cancel = button("Cancel", "timer_cancel()")
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

    global stopwatch_label = label(time_to_format(0), 28, 0.5)
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

    global stopwatch_button_toggle = button("Start", "stopwatch_toggle()")
    stopwatch_button_toggle.margin(2)
    stopwatch_button_toggle.theme = "#FF4060"
    buttons.add(stopwatch_button_toggle)

    global stopwatch_button_lap = button("Lap", "stopwatch_lap()")
    stopwatch_button_lap.margin(2)
    buttons.add(stopwatch_button_lap)
    
    global stopwatch_button_reset = button("Reset", "stopwatch_reset()")
    stopwatch_button_reset.margin(2)
    buttons.add(stopwatch_button_reset)

    tab3.add(buttons)
    
    // WORLD CLOCK
    tab4 = container()
    tabs.add(tab4, "World Clock")

    title = label("World Clock", 12)
    title.margin(8, "", "", 8)
    tab4.add(title)
    
    global globe_canvas = costume("#globe", 96)
    globe_canvas.margin(30, 0, 70)
    tab4.add(globe_canvas)

    global globe_show_instructions = true

    global city_name = label("Hover over a red dot", 14)
    city_name.margin("", 10, 45)
    tab4.add(city_name)
    
    global city_info = label("to see information", 14)
    city_info.margin("", 10, 25)
    tab4.add(city_info)
    
    global city_time = label("and the current time", 14)
    city_time.margin("", 10, 5)
    tab4.add(city_time)

    window.add(tabs)
}

def frame() {
    time_mode.state = os.full_hours
    time_label.text = os.time_seconds_str

    timer_button_toggle.theme = "#FF4060"
    if (timer_is_running) {
        timer -= os.delta
        if (timer <= 0) {
            alert()
            timer_cancel()
        } else {
            timer_label.text = time_to_format(timer)
            timer_canvas.data = timer/total_timer
        }
    } elif (timer_is_edit_mode) {
        parse(timer_hours_input, 99)
        parse(timer_minutes_input, 59)
        parse(timer_seconds_input, 59)
        if ((60*60*number(timer_hours_input.text) + 60*number(timer_minutes_input.text) + number(timer_seconds_input.text)) <= 0) {
            timer_button_toggle.theme = 0.1
        }
    }
    
    if (stopwatch_is_running) {
        stopwatch += os.delta
    }
    stopwatch_label.text = time_to_format(stopwatch)

    if (globe_canvas.data == "") {
        if (!globe_show_instructions) {
            city_name.text = ""
            city_info.text = ""
            city_time.text = ""
        }
    } else {
        globe_show_instructions = false
        index = city_names.find(globe_canvas.data)
        city_name.text = "\\b\\u" + city_names.get(index) + "\\u\\b"
        city_info.text = "\\i" + city_infos.get(index) + "\\i"
        time = (60 * (os.hour - os.timezone + city_utcs.get(index)) + os.minute) % (24*60)
        hours = floor(time/60)
        minutes = time % 60
        if (os.full_hours) {
            ampm = ""
        } else {
            if (hours > 11) {
                ampm = " PM"
            } else {
                ampm = " AM"
            }
            if (hours > 12) {
                hours -= 12
            }
        }
        hours = str(hours)
        if (hours.length == 1) {
            hours = "0" + hours
        }
        minutes = str(minutes)
        if (minutes.length == 1) {
            minutes = "0" + minutes
        }
        utc = city_utcs.get(index)
        if ((utc % 1) != 0) {
            utc_minutes = ":" + (utc % 1)*60
            utc = floor(utc)
        } else {
            utc_minutes = ""
        }
        if (utc > 0) {
            utc = "+" + utc
        }
        city_time.text = "\\o" + hours + "\\o:\\o" + minutes + "\\o" + ampm + " (UTC" + utc + utc_minutes + ")"
    }

    window.title = list("Clock", "Timer", "Stopwatch", "World Clock").get(tabs.tab-1)
}

def parse(input, max) {
    int = parse_digits(input.text)
    int = str(min(max(int, 0), max))
    if (int.length == 1) {
        int = "0" + int
    }
    input.text = str(int)
}

def create_timer_label() {
    timer_is_edit_mode = false
    timer_inner.delete_children()
    global timer_label = Label(time_to_format(0), 16, 0.5)
    timer_inner.add(timer_label)
}

def create_timer_input() {
    timer_is_edit_mode = true
    timer_inner.delete_children()

    global timer_hours_input = input("00", 16)
    timer_hours_input.theme = 0.1
    timer_hours_input.marginX(5, 68)
    timer_inner.add(timer_hours_input)

    global timer_minutes_input = input("01", 16)
    timer_minutes_input.theme = 0.1
    timer_minutes_input.marginX(35, 38)
    timer_inner.add(timer_minutes_input)

    global timer_seconds_input = input("00", 16)
    timer_seconds_input.theme = 0.1
    timer_seconds_input.marginX(65, 8)
    timer_inner.add(timer_seconds_input)

    timer_label_1 = label(":", 16)
    timer_label_1.marginLeft = 32
    timer_inner.add(timer_label_1)
    
    timer_label_2 = label(":", 16)
    timer_label_2.marginLeft = 61
    timer_inner.add(timer_label_2)
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
    minutes = floor((time/60) % 60)
    if (minutes < 10) {
        minutes = "0" + minutes
    }
    format = "\\o" + minutes + "\\o:\\o" + seconds + "\\o:\\o" + centiseconds + "\\o"
    if (time >= 3600) {
        hours = floor((time/3600) % 60)
        format = "\\o" + hours + "\\o:" + format
    }
    return format
    
}

def timer_toggle() {
    if (timer_is_edit_mode && timer_button_toggle.theme == 0.1) { return }
    timer_is_running = !timer_is_running
    if (timer_is_running) {
        timer_button_toggle.text = "Pause"
        if (timer_is_edit_mode) {
            parse(timer_hours_input, 99)
            parse(timer_minutes_input, 59)
            parse(timer_seconds_input, 59)
            total_timer = 60*60*number(timer_hours_input.text) + 60*number(timer_minutes_input.text) + number(timer_seconds_input.text)
            timer = total_timer
            create_timer_label()
        }
    } else {
        timer_button_toggle.text = "Start"
    }
}

def timer_cancel() {
    timer_is_running = false
    timer = 0
    timer_button_toggle.text = "Start"
    timer_canvas.data = 0
    if (!timer_is_edit_mode) {
        create_timer_input()
        timer_hours_input.text = floor((total_timer/3600) % 60)
        if (timer_hours_input.text.length == 1) { timer_hours_input.text = "0" + timer_hours_input.text }
        timer_minutes_input.text = floor((total_timer/60) % 60)
        if (timer_minutes_input.text.length == 1) { timer_minutes_input.text = "0" + timer_minutes_input.text }
        timer_seconds_input.text = floor(total_timer % 60)
        if (timer_seconds_input.text.length == 1) { timer_seconds_input.text = "0" + timer_seconds_input.text }
    }
    total_timer = 0
}

def alert() {
    if (!exists("alert_window")) {
        global alert_window = 0
    }

    if (type(alert_window) == "element") {
        alert_window.delete_children()
        alert_window.focus()
    } else {
        alert_window = window(140, 60)
        alert_window.mode = "no resize"
        alert_window.center()
        alert_window.title = "Timer finished"
        alert_window.onClose = "alert_close()"
    }

    alert_label = label("\\bTimer finished\\b", 16, 0.5)
    alert_label.marginTop = 10
    alert_window.add(alert_label)

    alert_button = button("close")
    alert_button.theme = "#FF4060"
    alert_button.marginBottom = 8
    alert_button.width = 50
    alert_button.onClick = "alert_close()"
    alert_window.add(alert_button)

    os.play_sound("Ring Tone")
}

def alert_close() {
    if (type(alert_window) == "element") {
        alert_window.delete()
    }
    os.stop_sound("Ring Tone")
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
    if (!stopwatch_is_running) {return}
    lapCount += 1
    lap = container()
    lap.height = 18

    lapCountLabel = label(lapCount)
    lapCountLabel.margin("", "", "", 4)
    lap.add(lapCountLabel)
    
    lapTimeLabel = label(stopwatch_label.text)
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

def toggleFullHours() {
    os.set_full_hours(!os.full_hours)
}