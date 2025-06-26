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
    theme_title.marginTop = 10
    home_vbox.add(theme_title)

    // global test_title = label("Test", 11)
    // test_title.text = os.theme
    // home_vbox.add(test_title)

    theme_container = hContainer()
    theme_container.minWidth = 200
    theme_container.minHeight = 45
    theme_container.size("fill", "shrink")
    theme_container.marginX(0, 0)
    home_vbox.add(theme_container)

    global theme_dark = button("Dark mode", "enable_dark_mode()")
    theme_dark.minHeight = 45
    theme_dark.minWidth = 60
    theme_dark.size("fill", "shrink")
    theme_dark.margin("5","5","5","0")
    theme_container.add(theme_dark)

    global theme_light = button("Light mode", "enable_light_mode()")
    theme_light.minHeight = 45
    theme_light.minWidth = 60
    theme_light.size("fill", "shrink")
    theme_light.margin("5","5","5","0")
    theme_container.add(theme_light)

    global theme_scheduled = button("Scheduled mode", "enable_scheduled_mode()")
    theme_scheduled.minHeight = 45
    theme_scheduled.minWidth = 60
    theme_scheduled.size("fill", "shrink")
    theme_scheduled.margin("5","5","5","0")
    theme_container.add(theme_scheduled)

    // VOLUME //
    
    volume_title = label("Volume", 12)
    volume_title.marginTop = 10
    home_vbox.add(volume_title)

    vol_container = hContainer()
    vol_container.size("fill", "shrink")
    vol_container.marginX(0, 0)
    home_vbox.add(vol_container)

    global vol_off = button("Volume off", "volume_off()")
    vol_off.minHeight = 20
    vol_off.minWidth = 60
    vol_off.margin("5","5","5","0")
    vol_container.add(vol_off)

    global vol_on = button("Volume on", "volume_on()")
    vol_on.minHeight = 20
    vol_on.minWidth = 60
    vol_on.margin("5","5","5","0")
    vol_container.add(vol_on)

    // SAVE DATA

    data_title = label("Save Data", 12)
    data_title.marginTop = 10
    home_vbox.add(data_title)

    data_label = label("Save your data to the cloud to pick up where you left off on the next startup!", 11)
    if (os.guest == 1) {
        data_label.text = "Please log in to save your data to the cloud"
    }

    data_label.wrap = 1
    home_vbox.add(data_label)

    global data_state = 0
    // State 0 = save, state 1 = saving, state 2 = saved

    global data_button = button("Save", "save_data()")
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
    cust_theme_title.marginTop = 10
    cust_vbox.add(cust_theme_title)

    cust_theme_container = hContainer()
    cust_theme_container.minWidth = 200
    cust_theme_container.minHeight = 45
    cust_theme_container.size("fill", "shrink")
    //cust_theme_container.marginX(0, 0)
    cust_vbox.add(cust_theme_container)

    global cust_theme_dark = button("Dark mode", "enable_dark_mode()")
    cust_theme_dark.minHeight = 45
    cust_theme_dark.minWidth = 60
    cust_theme_dark.size("fill", "shrink")
    cust_theme_dark.margin("5","5","5","0")
    cust_theme_container.add(cust_theme_dark)

    global cust_theme_light = button("Light mode", "enable_light_mode()")
    cust_theme_light.minHeight = 45
    cust_theme_light.minWidth = 60
    cust_theme_light.size("fill", "shrink")
    cust_theme_light.margin("5","5","5","0")
    cust_theme_container.add(cust_theme_light)

    global cust_theme_scheduled = button("Scheduled mode", "enable_scheduled_mode()")
    cust_theme_scheduled.minHeight = 45
    cust_theme_scheduled.minWidth = 60
    cust_theme_scheduled.size("fill", "shrink")
    cust_theme_scheduled.margin("5","5","5","0")
    cust_theme_container.add(cust_theme_scheduled)

    cust_vbox.add(cust_theme_container)

    // WALLPAPER

    cust_wallpaper_title = label("Wallpaper", 12)
    cust_wallpaper_title.marginTop = 10
    cust_vbox.add(cust_wallpaper_title)

    cust_bg_container = hContainer()
    cust_bg_container.minWidth = 200
    cust_bg_container.minHeight = 45
    cust_bg_container.size("fill", "shrink")
    //cust_bg_container.marginX(0, 0)
    cust_vbox.add(cust_bg_container)

    global cust_bgOne = button("BG1", "bgOne()")
    cust_bgOne.minHeight = 45
    cust_bgOne.minWidth = 60
    cust_bgOne.size("fill", "shrink")
    cust_bgOne.margin("5","5","5","0")
    cust_bg_container.add(cust_bgOne)

    global cust_bgTwo = button("BG2", "bgTwo()")
    cust_bgTwo.minHeight = 45
    cust_bgTwo.minWidth = 60
    cust_bgTwo.size("fill", "shrink")
    cust_bgTwo.margin("5","5","5","0")
    cust_bg_container.add(cust_bgTwo)

    global cust_bgThree = button("BG3", "bgThree()")
    cust_bgThree.minHeight = 45
    cust_bgThree.minWidth = 60
    cust_bgThree.size("fill", "shrink")
    cust_bgThree.margin("5","5","5","0")
    cust_bg_container.add(cust_bgThree)

    // OTHER OPTIONS

    cust_options_label = label("Other", 11)
    cust_options_label.marginTop = 10
    cust_vbox.add(cust_options_label)

    global fullHours = switch("Use 24-Hour time", "toggleFullHours()")
    fullHours.state = os.full_hours
    cust_vbox.add(fullHours)

    global startWeekOnSunday = switch("Start week on Sunday", "toggleEffectEight()")
    startWeekOnSunday.state = os.get_effect(8)
    cust_vbox.add(startWeekOnSunday)

    global showSeconds = switch("Show seconds", "toggleEffectSix()")
    showSeconds.state = os.get_effect(6)
    cust_vbox.add(showSeconds)

    global trail_effect = switch("Enable mouse trail", "toggleEffectFour()")
    trail_effect.state = os.get_effect(4)
    cust_vbox.add(trail_effect)

    global click_effect = switch("Enable click effect", "toggleEffectFive()")
    click_effect.state = os.get_effect(5)
    cust_vbox.add(click_effect)
    
    // SAVE DATA

    cust_data_title = label("Save Data", 12)
    cust_data_title.marginTop = 10
    cust_vbox.add(cust_data_title)

    cust_data_label = label("Save your data to the cloud to pick up where you left off on the next startup!", 11)
    if (os.guest == 1) {
        cust_data_label.text = "Please log in to save your data to the cloud"
    }
    cust_data_label.wrap = 1
    cust_vbox.add(cust_data_label)

    global cust_data_button = button("Save", "save_data()")
    cust_data_button.minWidth = 66
    cust_data_button.minHeight = 16
    cust_data_button.shrink()
    if (os.guest == 0) {
        cust_data_button.theme = "#FF4060"
    } else {
        cust_data_button.theme = 0.2
    }
    cust_data_button.marginX("", 0)
    cust_vbox.add(cust_data_button)

    ////////////
    // SYSTEM //
    ////////////

    tab3 = container()
    tabs.add(tab3, "System")

    sys_vbox = vScrollContainer()
    sys_vbox.minWidth = 200
    sys_vbox.minHeight = 600
    sys_vbox.fill()
    sys_vbox.margin(10)
    tab3.add(sys_vbox)

    sys_title = label("System", 13)
    sys_vbox.add(sys_title)

    // VOLUME //
    
    sys_vol_title = label("Volume", 12)
    sys_vol_title.marginTop = 10
    sys_vbox.add(sys_vol_title)

    sys_vol_container = hContainer()
    sys_vol_container.size("fill", "shrink")
    sys_vol_container.marginX(0, 0)
    sys_vbox.add(sys_vol_container)

    global sys_vol_off = button("Volume off", "volume_off()")
    sys_vol_off.minHeight = 20
    sys_vol_off.minWidth = 60
    sys_vol_off.margin("5","5","5","0")
    sys_vol_container.add(sys_vol_off)

    global sys_vol_on = button("Volume on", "volume_on()")
    sys_vol_on.minHeight = 20
    sys_vol_on.minWidth = 60
    sys_vol_on.margin("5","5","5","0")
    sys_vol_container.add(sys_vol_on)

    // OTHER OPTIONS

    sys_option_title = label("Developer options", 12)
    sys_option_title.marginTop = 10
    sys_vbox.add(sys_option_title)

    global showFps = switch("Show FPS", "toggleEffectOne()")
    showFps.state = os.get_effect(1)
    sys_vbox.add(showFps)

    global showDelta = switch("Show deltaTime", "toggleEffectTwo()")
    showDelta.state = os.get_effect(2)
    sys_vbox.add(showDelta)

    global showAnimTime = switch("Show animTime", "toggleEffectThree()")
    showAnimTime.state = os.get_effect(3)
    sys_vbox.add(showAnimTime)

    global showPreinstalled = switch("Show pre-installed apps list", "toggleEffectSeven()")
    showPreinstalled.state = os.get_effect(7)
    sys_vbox.add(showPreinstalled)

    // SAVE DATA

    sys_data_title = label("Save Data", 12)
    sys_data_title.marginTop = 10
    sys_vbox.add(sys_data_title)

    sys_data_label = label("Save your data to the cloud to pick up where you left off on the next startup!", 11)
    if (os.guest == 1) {
        sys_data_label.text = "Please log in to save your data to the cloud"
    }
    sys_data_label.wrap = 1
    sys_vbox.add(sys_data_label)

    global sys_data_button = button("Save", "save_data()")
    sys_data_button.minWidth = 66
    sys_data_button.minHeight = 16
    sys_data_button.shrink()
    if (os.guest == 0) {
        sys_data_button.theme = "#FF4060"
    } else {
        sys_data_button.theme = 0.2
    }
    sys_data_button.marginX("", 0)
    sys_vbox.add(sys_data_button)


    ///////////
    // ABOUT //
    ///////////

    tab4 = container()
    tabs.add(tab4, "About")

    info_vbox = vScrollContainer()
    info_vbox.minWidth = 200
    info_vbox.minHeight = 600
    info_vbox.fill()
    info_vbox.margin(10)
    tab4.add(info_vbox)

    info_title = label("About Red OS", 13)
    info_vbox.add(info_title)

    info_sys_title = label("System information", 12)
    info_sys_title.marginTop = 10
    info_sys_title.wrap = 1
    info_vbox.add(info_sys_title)

    info_sys_round = label("Red OS - Round 5 edition", 11)
    info_sys_turbowarp = label("Running on Scratch", 11)
    if (os.turbowarp == 1) {
        info_sys_turbowarp.text = "Running on Turbowarp"
    }
    info_sys_account = label("Account: Guest", 11)
    if (os.guest == 0) {
        info_sys_account.text = "Account: " + os.username
    }
    info_sys_language = label("Powered by RedScript", 11)

    info_sys_round.wrap = 1
    info_sys_turbowarp.wrap = 1
    info_sys_account.wrap = 1
    info_sys_language.wrap = 1

    info_vbox.add(info_sys_round)
    info_vbox.add(info_sys_turbowarp)
    info_vbox.add(info_sys_account)
    info_vbox.add(info_sys_language)


    info_soft_title = label("Software", 12)
    info_soft_title.marginTop = 10
    info_soft_title.wrap = 1
    info_vbox.add(info_soft_title)

    info_soft_version = label("Red OS v2.13", 11)
    info_soft_draco = label("Draco v1.2", 11)
    info_soft_scratch = label("Made with Scratch 3.0", 11)

    info_soft_version.wrap = 1
    info_soft_draco.wrap = 1
    info_soft_scratch.wrap = 1

    info_vbox.add(info_soft_version)
    info_vbox.add(info_soft_draco)
    info_vbox.add(info_soft_scratch)


    window.add(tabs)

    info_cred_title = label("Credits", 12)
    info_cred_title.marginTop = 10
    info_cred_title.wrap = 1
    info_vbox.add(info_cred_title)

    cred_leaders_title = label("Team leaders:", 11)
    cred_josh = label("@Joshisaurio - Leader", 10)
    cred_citrus = label("Citrus - Leader", 10)
    cred_kroko = label("@Krokobil - Leader", 10)

    cred_coders_title = label("Coders:", 11)
    cred_spiel = label("@SpieleTyp - Code Leader", 10)
    cred_chez = label("@chez_muffin_boi - Coder", 10)
    cred_nerd = label("Notanerd - Coder", 10)

    cred_designers_title = label("Designers:", 11)
    cred_muz=label("@muzlovescereal- Design leader", 10)
    cred_shine=label("Highshine- Designer", 10)
    
    cred_formers_title= label("Former members:", 11)
    cred_patrixx = label("Patrixx - Former leader", 10)
    cred_eterk = label("@CaptainEterk - Former coder", 10)
    cred_fuzzee = label("@Fuzzee_animations - Former coder", 10)

    cred_leaders_title.wrap = 1
    cred_josh.wrap = 1
    cred_citrus.wrap = 1
    cred_kroko.wrap = 1

    cred_coders_title.wrap = 1
    cred_spiel.wrap = 1
    cred_chez.wrap = 1
    cred_nerd.wrap = 1

    cred_designers_title.wrap = 1
    cred_muz.wrap = 1
    cred_shine.wrap = 1

    cred_formers_title.wrap = 1
    cred_patrixx.wrap = 1
    cred_eterk.wrap = 1
    cred_fuzzee.wrap = 1

    info_vbox.add(cred_leaders_title)
    info_vbox.add(cred_josh)
    info_vbox.add(cred_citrus)
    info_vbox.add(cred_kroko)

    info_vbox.add(cred_coders_title)
    info_vbox.add(cred_spiel)
    info_vbox.add(cred_chez)
    info_vbox.add(cred_nerd)

    info_vbox.add(cred_designers_title)
    info_vbox.add(cred_muz)
    info_vbox.add(cred_shine)

    info_vbox.add(cred_formers_title)
    info_vbox.add(cred_patrixx)
    info_vbox.add(cred_eterk)
    info_vbox.add(cred_fuzzee)


    window.add(tabs)
}

def frame() {
    //////////
    // HOME //
    //////////

    //test_title.text = "Current theme: " + os.theme

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


    ///////////////////
    // CUSTOMIZATION //
    ///////////////////

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
    showSeconds.state = os.get_effect(6)
    startWeekOnSunday.state = os.get_effect(8)

    fullHours.state = os.full_hours

    if (data_state==0) {
        cust_data_button.text = "Save"
    } elif (data_state==1) {
        cust_data_button.text = "Saving..."
    } elif (data_state==2) {
        cust_data_button.text = "Saved"
    }

    ////////////
    // SYSTEM //
    ////////////

    if (os.volume==0) {
        sys_vol_off.theme = "#FF4060"
    } else {
        sys_vol_off.theme = 0.1
    }

    if (os.volume>0) {
        sys_vol_on.theme = "#FF4060"
    } else {
        sys_vol_on.theme = 0.1
    }

    if (data_state==0) {
        sys_data_button.text = "Save"
    } elif (data_state==1) {
        sys_data_button.text = "Saving..."
    } elif (data_state==2) {
        sys_data_button.text = "Saved"
    }

    showFps.state = os.get_effect(1)

    showDelta.state = os.get_effect(2)

    showAnimTime.state = os.get_effect(3)

    showPreinstalled.state = os.get_effect(7)
}

def enable_dark_mode() {
    os.set_theme("dark")
    data_state = 0
}

def enable_light_mode() {
    os.set_theme("light")
    data_state = 0
}

def enable_scheduled_mode() {
    os.set_theme("scheduled")
    data_state = 0
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
    if (data_state == 1) {
        data_state = 2
    }
    os.print("Data saved")
}

def bgOne {
    os.set_bg("BG1")
    data_state = 0
}
def bgTwo {
    os.set_bg("BG2")
    data_state = 0
}
def bgThree {
    os.set_bg("BG3")
    data_state = 0
}

def toggleEffectOne {
    os.set_effect(1, !os.get_effect(1))
}

def toggleEffectTwo {
    os.set_effect(2, !os.get_effect(2))
}

def toggleEffectThree {
    os.set_effect(3, !os.get_effect(3))
}

def toggleEffectFour {
    os.set_effect(4, !os.get_effect(4))
}

def toggleEffectFive {
    os.set_effect(5, !os.get_effect(5))
}

def toggleEffectSix {
    os.set_effect(6, !os.get_effect(6))
}

def toggleEffectSeven {
    os.set_effect(7, !os.get_effect(7))
}

def toggleEffectEight {
    os.set_effect(8, !os.get_effect(8))
}

def toggleFullHours {
    os.set_full_hours(!os.full_hours)
}