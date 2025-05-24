def init() {
    global window = window()
    window.center()

    title = label("Calendar", 20)
    title.margin(10)
    title.marginBottom = ""
    
    window.add(title)

    global time = Label(os.date + "." + os.month + "." + os.year, 10)
    time.margin(50, 10, "")
    
    window.add(time)
}
