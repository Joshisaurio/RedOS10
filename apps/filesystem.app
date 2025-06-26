// Settings by @Joshisaurio
// Still unfinished, sorry

def init() {
    global window = window()
    window.center()

    global file_container = vScrollContainer()
    file_container.fill()
    file_container.margin(20, "", 20, 5)
    window.add(file_container)

    global top_bar = hcontainer()
    top_bar.margin(0, 0, "", 0)
    top_bar.size("fill", 20)
    top_bar.theme = 0.1
    window.add(top_bar)

    move_top = button("move top", "move_top")
    move_top.size("fill")
    move_top.margin(2)
    top_bar.add(move_top)

    new_folder = button("new folder")
    new_folder.size("fill")
    new_folder.margin(2)
    top_bar.add(new_folder)

    global bottom_bar = hcontainer()
    bottom_bar.margin("", 0, 0, 0)
    bottom_bar.size("fill", 20)
    bottom_bar.theme = 0.1
    window.add(bottom_bar)

    global selected_file = 0
    load_path("red_os/apps")
}

def load_path(new_path) {
    global path = new_path
    global path_list = path.split("/")
    window.title = path_list.get(path_list.length-1)
    file_container.delete_children()
    bottom_bar.delete_children()
    file_list = os.list_folder(path)
    i = 0
    depth = 0
    while (i < file_list.length) {
        if (file_list.get(i) == 0) {
            depth -= 1
        } elif (depth > 0) {
            if (file_list.get(i) == 1) {
                // Folder
                i += 1
                depth += 1
            } elif (file_list.get(i) == 2) {
                // File
                i += 2
            }
        } else {
            file = container()
            file.size("fill", "shrink")
            file_container.add(file)
            
            icon = costume()
            icon.scale = 8
            icon.size(15)
            icon.margin(2, "", 2, 2)
            file.add(icon)

            label = label(file_list.get(i+1))
            label.size("fill", "shrink")
            label.margin(2, "", 0, 20)
            file.add(label)
            
            if (file_list.get(i) == 1) {
                // Folder
                icon.costume = "filesystem//icon-folder"
                i += 1
                depth += 1
            } elif (file_list.get(i) == 2) {
                // File
                if (label.text.endswith(".img")) {
                    icon.costume = "filesystem//icon-image"
                } elif (label.text.endswith(".song")) {
                    icon.costume = "filesystem//icon-music"
                } else {
                    icon.costume = "filesystem//icon-text"
                }
                i += 2
            }
        }
        i += 1
    }
}

def click_file(file) {
    if (selected_file == 0) {
        selected_file = 
    }
}

def make_bottom_bar() {
    bottom_bar.delete_children()
    rename = button("rename")
    rename.size("fill")
    rename.margin(2)
    bottom_bar.add(rename)

    delete = button("delete")
    delete.size("fill")
    delete.margin(2)
    bottom_bar.add(delete)
}

def move_top() {
    if (path_list.length < 2) {return}
    new_path = ""
    i = 0
    while (i < path_list.length - 1) {
        if (i > 0) {
            new_path += "/"
        }
        new_path += path_list.get(i)
        i += 1
    }
    load_path(new_path)
}