// @Joshisaurio's note app

def init () {
    global window = window()
    window.center()
    window.minSize(180, 100)

    tabs = tabs()
    tabs.fill()
    tabs.tab = 1
    tabs.sideWidth = 60

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

    note1 = vscrollcontainer()
    note1.theme = 0.1
    note1.margin(30, 5, 5, 5)
    note1.fill()
    note1container.add(note1)

    text_field = input("", 12)
    text_field.wrap = 1
    //text_field.minHeight = 200
    //text_field.minWidth = 200
    text_field.margin(5)
    text_field.fill()
    text_field.focus = 1
    note1.add(text_field)


    window.add(tabs)
}

def frame () {

}