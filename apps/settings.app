// Settings by @Joshisaurio
// Still unfinished, sorry

def init() {
    global window = window()
    window.center()

    tabs = tabs()
    tabs.fill()
    tabs.tab = 1

    //////////
    // HOME //
    //////////

    tab1 = container()
    tabs.add(tab1, "Home")

    home_vbox = vScrollContainer()
    home_vbox.minWidth = 200
    home_vbox.minHeight = 600
    home_vbox.fill()
    home_vbox.margin(10)
    tab1.add(home_vbox)

    home_title = label("Home", 13)
    home_vbox.add(home_title)

    // THEMES
    theme_title = label("Theme", 12)
    home_vbox.add(theme_title)

    global test_title = label("Test", 11)
    test_title.text = os.theme
    home_vbox.add(test_title)

    theme_container = hContainer()
    theme_container.minWidth = 200
    theme_container.minHeight = 45
    theme_container.size("fill", "shrink")
    theme_container.marginX(0, 0)
    home_vbox.add(theme_container)

    global theme_dark = button("Dark mode", "enable_dark_mode")
    theme_dark.minHeight = 45
    theme_dark.minWidth = 60
    theme_dark.size("fill", "shrink")
    theme_dark.margin("5","5","5","0")
    theme_container.add(theme_dark)

    global theme_light = button("Light mode", "enable_light_mode")
    theme_light.minHeight = 45
    theme_light.minWidth = 60
    theme_light.size("fill", "shrink")
    theme_light.margin("5","5","5","0")
    theme_container.add(theme_light)

    global theme_scheduled = button("Scheduled mode", "enable_scheduled_mode")
    theme_scheduled.minHeight = 45
    theme_scheduled.minWidth = 60
    theme_scheduled.size("fill", "shrink")
    theme_scheduled.margin("5","5","5","0")
    theme_container.add(theme_scheduled)

    // VOLUME //
    
    volume_title = label("Volume", 12)
    home_vbox.add(volume_title)

    vol_container = hContainer()
    vol_container.size("fill", "shrink")
    vol_container.marginX(0, 0)
    home_vbox.add(vol_container)

    global vol_off = button("Volume off", "volume_off")
    vol_off.minHeight = 20
    vol_off.minWidth = 60
    vol_off.margin("5","5","5","0")
    vol_container.add(vol_off)

    global vol_on = button("Volume on", "volume_on")
    vol_on.minHeight = 20
    vol_on.minWidth = 60
    vol_on.margin("5","5","5","0")
    vol_container.add(vol_on)

    // SAVE DATA

    data_title = label("Save Data", 12)
    home_vbox.add(data_title)

    data_label = label("Save your data to the cloud to pick up where you left off on the next startup!", 11)
    if (os.guest == 1) {
        data_label.text = "Please log in to save your data to the cloud"
    }

    data_label.wrap = 1
    home_vbox.add(data_label)

    global data_state = 0
    // State 0 = save, state 1 = saving, state 2 = saved

    global data_button = button("Save", "save_data")
    data_button.minWidth = 66
    data_button.minHeight = 16
    data_button.shrink()
    if (os.guest == 0) {
        data_button.theme = "#FF4060"
    } else {
        data_button.theme = 0.2
    }
    data_button.marginX("", 0)
    home_vbox.add(data_button)
    
    ///////////////////
    // CUSTOMIZATION //
    ///////////////////

    tab2 = container()
    tabs.add(tab2, "Customization")

    cust_vbox = vScrollContainer()
    cust_vbox.minWidth = 200
    cust_vbox.minHeight = 600
    cust_vbox.fill()
    cust_vbox.margin(10)
    tab2.add(cust_vbox)

    cust_title = label("Customization", 13)
    cust_vbox.add(cust_title)

    // THEMES
    cust_theme_title = label("Theme", 12)
    cust_vbox.add(cust_theme_title)

    cust_theme_container = hContainer()
    cust_theme_container.minWidth = 200
    cust_theme_container.minHeight = 45
    cust_theme_container.size("fill", "shrink")
    //cust_theme_container.marginX(0, 0)
    cust_vbox.add(cust_theme_container)

    global cust_theme_dark = button("Dark mode", "enable_dark_mode")
    cust_theme_dark.minHeight = 45
    cust_theme_dark.minWidth = 60
    cust_theme_dark.size("fill", "shrink")
    cust_theme_dark.margin("5","5","5","0")
    cust_theme_container.add(cust_theme_dark)

    global cust_theme_light = button("Light mode", "enable_light_mode")
    cust_theme_light.minHeight = 45
    cust_theme_light.minWidth = 60
    cust_theme_light.size("fill", "shrink")
    cust_theme_light.margin("5","5","5","0")
    cust_theme_container.add(cust_theme_light)

    global cust_theme_scheduled = button("Scheduled mode", "enable_scheduled_mode")
    cust_theme_scheduled.minHeight = 45
    cust_theme_scheduled.minWidth = 60
    cust_theme_scheduled.size("fill", "shrink")
    cust_theme_scheduled.margin("5","5","5","0")
    cust_theme_container.add(cust_theme_scheduled)

    cust_vbox.add(cust_theme_container)

    // WALLPAPER

    cust_theme_title = label("Wallpaper", 12)
    cust_vbox.add(cust_theme_title)

    cust_bg_container = hContainer()
    cust_bg_container.minWidth = 200
    cust_bg_container.minHeight = 45
    cust_bg_container.size("fill", "shrink")
    //cust_bg_container.marginX(0, 0)
    cust_vbox.add(cust_bg_container)

    global cust_bgOne = button("BG1", "bgOne")
    cust_bgOne.minHeight = 45
    cust_bgOne.minWidth = 60
    cust_bgOne.size("fill", "shrink")
    cust_bgOne.margin("5","5","5","0")
    cust_bg_container.add(cust_bgOne)

    global cust_bgTwo = button("BG2", "bgTwo")
    cust_bgTwo.minHeight = 45
    cust_bgTwo.minWidth = 60
    cust_bgTwo.size("fill", "shrink")
    cust_bgTwo.margin("5","5","5","0")
    cust_bg_container.add(cust_bgTwo)

    global cust_bgThree = button("BG3", "bgThree")
    cust_bgThree.minHeight = 45
    cust_bgThree.minWidth = 60
    cust_bgThree.size("fill", "shrink")
    cust_bgThree.margin("5","5","5","0")
    cust_bg_container.add(cust_bgThree)

    options_label = label("Options", 11)
    cust_vbox.add(options_label)

    global trail_effect = switch("Enable mouse trail")
    trail_effect.state = os.get_effect(4)
    cust_vbox.add(trail_effect)

    global click_effect = switch("Enable click effect")
    click_effect.state = os.get_effect(5)
    cust_vbox.add(click_effect)

    window.add(tabs)
}

def frame() {
    // HOME //
    test_title.text = "Current theme: " + os.theme

    if (os.theme == "dark") {
        theme_dark.theme = "#FF4060"
    } else {
        theme_dark.theme = 0.1
    }

    if (os.theme == "light") {
        theme_light.theme = "#FF4060"
    } else {
        theme_light.theme = 0.1
    }

    if (os.theme == "scheduled") {
        theme_scheduled.theme = "#FF4060"
    } else {
        theme_scheduled.theme = 0.1
    }

    if (os.volume==0) {
        vol_off.theme = "#FF4060"
    } else {
        vol_off.theme = 0.1
    }

    if (os.volume>0) {
        vol_on.theme = "#FF4060"
    } else {
        vol_on.theme = 0.1
    }

    if (data_state==0) {
        data_button.text = "Save"
    } elif (data_state==1) {
        data_button.text = "Saving..."
    } elif (data_state==2) {
        data_button.text = "Saved"
    }



    // CUSTOMIZATION //
    if (os.theme == "dark") {
        cust_theme_dark.theme = "#FF4060"
    } else {
        cust_theme_dark.theme = 0.1
    }

    if (os.theme == "light") {
        cust_theme_light.theme = "#FF4060"
    } else {
        cust_theme_light.theme = 0.1
    }

    if (os.theme == "scheduled") {
        cust_theme_scheduled.theme = "#FF4060"
    } else {
        cust_theme_scheduled.theme = 0.1
    }

    if (os.bg=="BG1") {
        cust_bgOne.theme = "#FF4060"
    } else {
        cust_bgOne.theme = 0.1
    }
    if (os.bg=="BG2") {
        cust_bgTwo.theme = "#FF4060"
    } else {
        cust_bgTwo.theme = 0.1
    }
    if (os.bg=="BG3") {
        cust_bgThree.theme = "#FF4060"
    } else {
        cust_bgThree.theme = 0.1
    }


    trail_effect.state = os.get_effect(4)
    click_effect.state = os.get_effect(5)
}

def enable_dark_mode() {
    os.set_theme("dark")
    os.print("Switched theme to dark")
}

def enable_light_mode() {
    os.set_theme("light")
    os.print("Switched theme to light")
}

def enable_scheduled_mode() {
    os.set_theme("scheduled")
    os.print("Switched theme to scheduled")
}

def volume_off () {
    os.set_volume(0)
    os.print("Set volume to 0")
}

def volume_on () {
    os.set_volume(100)
    os.print("Set volume to 100")
}

def save_data () {
    if (os.guest == 0) {
        data_state = 1
        os.print("Saving data...")
        os.save_all("data_saved")
    }
}

def data_saved (info) {
    os.print(info)
    data_state = 2
    os.print("Data saved")
}

def bgOne {
    os.set_bg("BG1")
}
def bgTwo {
    os.set_bg("BG2")
}
def bgThree {
    os.set_bg("BG3")
}