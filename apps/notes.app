def init () {
    open("", "New Note")
}

def open(path, name) {
    if (!exists("windows")) {
        global windows = list()
        global editors = list()
        global buttons = list()
        global paths = list()

        if(!os.exists_path("red_os/user/notes")) {
            os.add_folder("red_os/user", "notes")
        }
    }
    find_index = paths.find(path)
    if (find_index != -1) {
        if (type(windows.get(find_index)) == "element") {
            windows.get(find_index).focus()
            return
        }
    }
    index = windows.length
    window = window()
    window.center()
    window.minSize(180, 100)
    window.title = name
    window.onClose = "window_on_close(" + index + ")"

    editor = editor("", 12)
    if (path != "") {
        editor.text = os.read_file(path)
    }
    editor.theme = 0.1
    editor.margin(25, 5, 5, 5)
    editor.focus()
    editor.fill()
    editor.onClick = "reset_button_theme(" + index + ")"
    window.add(editor)

    save_button = button("save", "save(" + index + ")")
    save_button.margin(5, "", "", 5)
    save_button.width = 50
    save_button.theme = "#FF4060"
    window.add(save_button)

    windows.add(window)
    editors.add(editor)
    buttons.add(save_button)
    paths.add(path)
}

def save(index) {
    path = paths.get(index)
    text = editors.get(index).text
    if (path == "") {
        os.run_code("filesystem", "save_file(\".txt\", \"red_os/user/notes\", \"" + text + "\", \"notes\", \"saved(" + index + "\")")
    } else {
        os.write_file(path, text)
        buttons.get(index).theme = "#52C832"
    }
}

def saved(index, path, filename) {
    paths.set(index, path)
    windows.get(index).title = filename
    buttons.get(index).theme = "#52C832"
}

def reset_button_theme(index) {
    buttons.get(index).theme = "#FF4060"
}

def window_on_close(index) {
    if (exists("windows")) {
        windows.set(index, 0)
        editors.set(index, 0)
        buttons.set(index, 0)
        paths.set(index, 0)
    }
}