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
    home_vbox.fill()
    home_vbox.margin(10)
    tab1.add(home_vbox)

    home_title = label("Home", 13)
    home_vbox.add(home_title)

    theme_title = label("Theme", 12)
    home_vbox.add(theme_title)

    theme_container = hContainer()
    theme_container.size("fill", 45)
    theme_container.shrink()
    home_vbox.add(theme_container)

    theme_dark = costume("settings//theme.dark", 1)
    theme_dark.margin("0", "")
    theme_container.add(theme_dark)

    theme_light = costume("settings//theme.light", 1)
    theme_light.margin("0", "")
    theme_container.add(theme_light)

    theme_scheduled = costume("settings//theme.scheduled", 1)
    theme_scheduled.margin("0", "")
    theme_container.add(theme_scheduled)

    volume_title = label("Volume", 12)
    home_vbox.add(volume_title)

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
