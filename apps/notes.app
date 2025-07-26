// @Joshisaurio's note app

def init () {
    global window = window()
    window.center()
    window.minSize(180, 100)
    window.title = "Notes"

    title1 = label("Note", 14)
    title1.margin(10, 5, "", 10)
    window.add(title1)

    global note1 = editor("", 12)
    note1.theme = 0.1
    note1.margin(30, 5, 5, 5)
    note1.focus()
    note1.fill()
    window.add(note1)
}