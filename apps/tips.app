def init() {
    global window = window()
    window.minSize(220, 100)
    window.title = "Tips"
    window.center()

    home_vbox = vScrollContainer()
    home_vbox.fill()
    home_vbox.margin(7.5)
    window.add(home_vbox)

    // FIRST ROW

    row1 = hContainer()
    row1.size("fill", "shrink")
    row1.margin(0)
    home_vbox.add(row1)
    row1.add(create_button("tips//quick", "How to use: Quick actions", "os.print(\"Button quick clicked\")"))
    row1.add(create_button("tips//how", "How it all works", "os.print(\"Button how clicked\")"))

    // SECOND ROW

    row2 = hContainer()
    row2.size("fill", "shrink")
    row2.margin(0)
    home_vbox.add(row2)
    row2.add(create_button("tips//draco", "What is Draco AI?", "os.print(\"Button draco clicked\")"))
    row2.add(create_button("tips//app", "How to create your own app", "os.print(\"Button app clicked\")"))
}

def create_button(icon, name, onClick) {
    button = container()
    button.height = 84
    button.margin(2.5)
    button.theme = 0.1
    button.onClick = onClick

    inner = container()
    inner.theme = 0.07
    inner.margin(1)
    button.add(inner)

    costume = costume(icon, 3)
    costume.margin(13, "", "")
    costume.size(35)
    inner.add(costume)

    label = label(name, 9, 0.5, 1)
    label.margin(50, 0, 0)
    inner.add(label)

    return button
}