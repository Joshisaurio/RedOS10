// @Joshisaurio's note app

def init () {
    global window = window()
    window.center()
    window.minSize(180, 100)
    window.title = "Notes"

    tab2 = container()
    window.add(tab2)

    note1container = container()
    note1container.fill()
    tab2.add(note1container)

    title1 = label("Note", 14)
    title1.margin(10, 5, "", 10)
    note1container.add(title1)

    global note1 = editor("", 12)
    note1.theme = 0.1
    note1.margin(30, 5, 5, 5)
    note1.focus = true
    note1.fill()
    note1container.add(note1)
}