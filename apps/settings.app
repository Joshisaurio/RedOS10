def init() {
    global window = window()
    window.center()

    tabs = tabs()
    tabs.fill()
    tabs.tab = 1

    // HOME
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

    theme_title = label("Theme", 12)
    home_vbox.add(theme_title)

    theme_container = hContainer()
    theme_container.minWidth = 200
    theme_container.minHeight = 45
    theme_container.size("fill", "shrink")
    theme_container.marginX(0, 0)
    home_vbox.add(theme_container)

    theme_dark = button("Dark mode")
    theme_dark.minHeight = 45
    theme_dark.minWidth = 60
    theme_dark.shrink()
    theme_dark.margin("5","5","5","0")
    theme_container.add(theme_dark)

    theme_light = button("Light mode")
    theme_light.minHeight = 45
    theme_light.minWidth = 60
    theme_light.shrink()
    theme_light.margin("5","5","5","0")
    // light_theme_color = #F2DFDF
    // theme_light.theme = light_theme_color
    theme_container.add(theme_light)

    theme_scheduled = button("Scheduled mode")
    theme_scheduled.minHeight = 45
    theme_scheduled.minWidth = 60
    theme_scheduled.shrink()
    theme_scheduled.margin("5","5","5","0")
    theme_container.add(theme_scheduled)

    volume_title = label("Volume", 12)
    home_vbox.add(volume_title)

    vol_container = hContainer()
    vol_container.size("fill", "shrink")
    vol_container.marginX(0, 0)
    home_vbox.add(vol_container)

    vol_off = button("Volume off")
    vol_off.minHeight = 20
    vol_off.minWidth = 60
    vol_off.margin("5","5","5","0")
    vol_container.add(vol_off)

    vol_on = button("Volume on")
    vol_on.minHeight = 20
    vol_on.minWidth = 60
    vol_on.margin("5","5","5","0")
    vol_container.add(vol_on)

    data_title = label("Save Data", 12)
    home_vbox.add(data_title)

    data_label = label("Save your data to the cloud to pick up where you left off on the next startup!", 11)
    data_label.wrap = 1
    home_vbox.add(data_label)

    data_button = button("Save")
    data_button.minWidth = 66
    data_button.minHeight = 16
    data_button.shrink()
    data_button.marginX("", 10)
    home_vbox.add(data_button)

    // I'll remove it later, it's just here for reference
    // time_mode = switch("Use 24-hour time")
    // home_vbox.add(time_mode)
    
    window.add(tabs)
}


def enable_dark_mode() {

}

def enable_light_mode() {

}

def enable_scheduled_mode() {

}