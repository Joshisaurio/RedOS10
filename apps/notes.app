// @Joshisaurio's note app

def init () {
    global window = window()
    window.center()
    window.minSize(180, 100)
    window.title = "Notes"

    global tabs = tabs()
    tabs.fill()
    tabs.tab = 2
    tabs.sideWidth = 60
    tabs.onClick = "tabs_click()"
    global last_tab = 0

    //////////
    // HOME //
    //////////
    tab1 = container()
    tabs.add(tab1, "Home")

    ////////////
    // NOTE 1 //
    ////////////

    tab2 = container()
    //tab2.fill()
    tabs.add(tab2, "Note 1")

    note1container = container()
    note1container.fill()
    tab2.add(note1container)

    title1 = label("Note 1", 14)
    title1.margin(10, 5, "", 10)
    note1container.add(title1)

    global note1 = editor("", 12)
    note1.theme = 0.1
    note1.margin(30, 5, 5, 5)
    note1.fill()
    note1container.add(note1)

    window.add(tabs)

    tabs_click()
}

def frame () {

}

def tabs_click() {
    if (tabs.tab == last_tab) {
        return
    }
    if (tabs.tab == 2) {
        note1.focus()
    }
    last_tab = tabs.tab
}