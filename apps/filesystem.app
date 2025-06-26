def init() {
    global _FOLDER = 1
    global _FILE = 2

    global window = window()
    window.center()

    global file_container = vScrollContainer()
    file_container.fill()
    file_container.margin(20, "", 20, 5)
    window.add(file_container)

    global up_bar = hcontainer()
    up_bar.margin(0, 0, "", 0)
    up_bar.size("fill", 20)
    up_bar.theme = 0.1
    window.add(up_bar)

    move_up = button("move up", "move_up()")
    move_up.size("fill")
    move_up.margin(2)
    up_bar.add(move_up)

    new_folder = button("new folder", "new_folder()")
    new_folder.size("fill")
    new_folder.margin(2)
    up_bar.add(new_folder)

    global bottom_bar = hcontainer()
    bottom_bar.margin("", 0, 0, 0)
    bottom_bar.size("fill", 20)
    bottom_bar.theme = 0.1
    window.add(bottom_bar)

    load_path("red_os/apps")
}

def load_path(new_path) {
    global selected_file = 0
    global rename_input = 0
    global path = new_path
    global path_list = path.split("/")
    window.title = path_list.get(path_list.length-1)
    file_container.delete_children()
    bottom_bar.delete_children()
    global folder_list = os.list_folder(path)
    global file_element_list = list()
    i = 0
    depth = 0
    while (i < folder_list.length) {
        if (folder_list.get(i) == 0) {
            depth -= 1
        } elif (depth > 0) {
            if (folder_list.get(i) == _FOLDER) {
                i += 1
                depth += 1
            } elif (folder_list.get(i) == _FILE) {
                i += 2
            }
        } else {
            file = container()
            file.size("fill", "shrink")
            file.onClick = "click_file(" + file_element_list.length + ", " + i + ")"
            file_container.add(file)
            file_element_list.add(file)
            
            icon = costume()
            icon.scale = 8
            icon.size(15)
            icon.margin(2, "", 2, 2)
            file.add(icon)

            label = label(folder_list.get(i+1))
            label.size("fill", "shrink")
            label.margin(2, "", 0, 20)
            file.add(label)
            
            if (folder_list.get(i) == _FOLDER) {
                icon.costume = "filesystem//icon-folder"
                i += 1
                depth += 1
            } elif (folder_list.get(i) == _FILE) {
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
    if (folder_list.length == 0) {
        no_files = label("\ino files\i")
        no_files.size("shrink")
        no_files.margin(20)
        file_container.add(no_files)
    }
}

def click_file(file_index, i) {
    file = file_element_list.get(file_index)
    if (rename_input != 0) {
        if (file != selected_file) {
            renameEnter()
        }
        return
    }
    global selected_type = folder_list.get(i)
    global selected_name = folder_list.get(i+1)
    global selected_path = path + "/" + selected_name
    if (selected_file != 0) {
        selected_file.theme = ""
        if (file == selected_file) {
            // Clicked selected file
            selected_file = 0
            if (selected_type == _FOLDER) {
                load_path(path + "/" + folder_list.get(i+1))
            } elif (selected_type == _FILE) {
                if (selected_name.endswith(".img")) {
                    os.warn("There is no app to open image files")
                } elif (selected_name.endswith(".song")) {
                    os.warn("There is no app to open song files")
                } elif (selected_name.endswith(".app")) {
                    os.warn("There is no app to open app files")
                } else {
                    os.warn("There is no app to open text files")
                }
            }
            return
        }
    }
    selected_file = file
    file.theme = 0.2
    make_bottom_bar()
}

def make_bottom_bar() {
    bottom_bar.delete_children()
    rename = button("rename", "rename()")
    rename.size("fill")
    rename.margin(2)
    bottom_bar.add(rename)

    delete = button("delete", "delete()")
    delete.size("fill")
    delete.margin(2)
    bottom_bar.add(delete)
}

def move_up() {
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

def new_folder() {
    os.add_folder(path, "New Folder")
    load_path(path)
}

def rename() {
    selected_file.delete_children()
    
    icon = costume()
    icon.scale = 8
    icon.size(15)
    icon.margin(2, "", 2, 2)
    selected_file.add(icon)

    rename_input = input(selected_name)
    rename_input.size("fill", "shrink")
    rename_input.margin(2, "", 0, 20)
    rename_input.onEnter = "renameEnter()"
    rename_input.focus()
    selected_file.add(rename_input)
    
    if (selected_type == _FOLDER) {
        icon.costume = "filesystem//icon-folder"
    } elif (selected_type == _FILE) {
        if (selected_name.endswith(".img")) {
            icon.costume = "filesystem//icon-image"
        } elif (selected_name.endswith(".song")) {
            icon.costume = "filesystem//icon-music"
        } else {
            icon.costume = "filesystem//icon-text"
        }
    }
}

def renameEnter() {
    if (selected_type == _FOLDER) {
        os.rename_folder(selected_path, rename_input.text)
    } elif (selected_type == _FILE) {
        os.rename_file(selected_path, rename_input.text)
    }
    load_path(path)
}

def delete() {
    if (selected_type == _FOLDER) {
        os.delete_folder(selected_path)
    } elif (selected_type == _FILE) {
        os.delete_file(selected_path)
    }
    load_path(path)
}