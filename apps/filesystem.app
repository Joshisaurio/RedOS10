def init_vars() {
    global _FOLDER = 1
    global _FILE = 2

    global _NORMAL = 0
    global _OPEN = 1
    global _SAVE = 2
    global _DELETED = -1
    
    if (!exists("windows_list")) {
        global windows_list = list()
    }
}

def init() {
    init_vars()

    create_window(_NORMAL, "red_os/apps", "", "", "")
}

def create_window(type, path, extension, callbackApp, callbackCode) {
    window_i = windows_list.length

    window = window()
    window.center()
    window.minSize(200, 65)

    tabs = tabs()
    tabs.margin(20, "", 20, 0)
    tabs.width = 70
    tabs.sideWidth = tabs.width
    tabs.onClick = "click_tab(" + window_i + ")"
    window.add(tabs)

    tab_path_list = list()
    add_tab(tabs, tab_path_list, "user", "red_os/user")
    add_tab(tabs, tab_path_list, "apps", "red_os/apps")
    add_tab(tabs, tab_path_list, "HyperText", "red_os/user/HyperText Documents")

    file_container = vScrollContainer()
    file_container.fill()
    file_container.margin(20, "", 20, tabs.width + 5)
    window.add(file_container)
    
    up_bar = hcontainer()
    up_bar.margin(0, 0, "", 0)
    up_bar.size("fill", 20)
    up_bar.theme = 0.1
    window.add(up_bar)

    move_up = button("move up", "move_up(" + window_i + ")")
    move_up.size("fill")
    move_up.margin(2)
    up_bar.add(move_up)

    new_folder = button("new folder", "new_folder(" + window_i + ")")
    new_folder.size("fill")
    new_folder.margin(2)
    up_bar.add(new_folder)

    if (type == _SAVE) {
        bottom_bar = container()
    } else {
        bottom_bar = hcontainer()
    }
    bottom_bar.margin("", 0, 0, 0)
    bottom_bar.size("fill", 20)
    bottom_bar.theme = 0.1
    window.add(bottom_bar)
    
    list = list(type, window, file_container, up_bar, bottom_bar, path, 0, 0, 0, 0, 0, 0, extension, callbackApp, callbackCode, tabs, tab_path_list)
    
    if (type == _SAVE) {
        save_filename = input()
        save_filename.size("fill")
        save_filename.margin(2, 60, 2, 2)
        save_filename.onEnter = "file_clicked_save(" + window_i + ")"
        bottom_bar.add(save_filename)

        save_button = button("save", save_filename.onEnter)
        save_button.size(60, "fill")
        save_button.margin(2, 2, 2, "")
        save_button.theme = "#FF4060"
        bottom_bar.add(save_button)
        list.add(save_filename)
    }

    windows_list.add(list)

    load_path(window_i, path)

    return list
}

def load_path(window_i, path) {
    windows_list.get(window_i).set(5, path) // path
    update_all_windows()
}

def update_all_windows() {
    i = 0
    while (i < windows_list.length) {
        update_window(i)
        i += 1
    }
}

def update_window(window_i) {
    list = windows_list.get(window_i)
    type = list.get(0)
    if (type == _DELETED) { return }
    list.set(6, 0) // selected_file
    list.set(9, 0) // selected_i
    list.set(7, 0) // rename_input
    path = list.get(5)
    tabs = list.get(15)
    tabs_path_list = list.get(16)
    tabs.tab = tabs_path_list.find(path)+1
    path_list = path.split("/")
    if (path_list.length < 2) {
        list.get(1).title = "Filesystem" // window
    } else {
        list.get(1).title = str(path_list.get(path_list.length-1)) // window
    }
    file_container = list.get(2)
    file_container.delete_children() // file_container
    if (type != _SAVE) {
        list.get(4).delete_children() // bottom_bar
    }
    file_element_list = list()
    if (!os.exists_path(path)) {
        path_does_not_exist = label("\\ipath does not exist\\i")
        path_does_not_exist.size("shrink")
        path_does_not_exist.margin(20)
        file_container.add(path_does_not_exist)
        list.set(8, file_element_list)
        return
    }
    folder_list = os.list_folder(path)
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
            if (type == _OPEN && folder_list.get(i) == _FILE && !folder_list.get(i+1).endswith(list.get(12))) {
                // don't show files with other extensions
                i += 2
            } else {
                file = container()
                file.size("fill", "shrink")
                if (folder_list.get(i) == _FOLDER || type != _SAVE) {
                    file.onClick = "click_file(" + window_i + ", " + file_element_list.length + ", " + i + ")"
                }
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
                    } elif (label.text.endswith(".app")) {
                        icon.costume = "filesystem//icon-app"
                    } else {
                        icon.costume = "filesystem//icon-text"
                    }
                    i += 2
                }
            }
        }
        i += 1
    }
    if (file_element_list.length == 0) {
        no_files = label("\\ino files\\i")
        no_files.size("shrink")
        no_files.margin(20)
        file_container.add(no_files)
    }
    list.set(8, file_element_list)
}

def add_tab(tabs, tab_path_list, name, path) {
    container = container()
    tabs.add(container, name)
    tab_path_list.add(path)
}

def click_tab(window_i) {
    list = windows_list.get(window_i)
    tabs = list.get(15)
    tab_path_list = list.get(16)
    load_path(window_i, tab_path_list.get(tabs.tab-1))
}

def click_file(window_i, file_index, i) {
    list = windows_list.get(window_i)
    type = list.get(0)
    file_element_list = list.get(8)
    file = file_element_list.get(file_index)
    selected_file = list.get(6)
    if (list.get(7) != 0) { // rename_input
        if (file != selected_file) {
            renameEnter()
        }
        return
    }
    path = list.get(5)
    folder_list = os.list_folder(path)
    list.set(9, i)
    selected_type = folder_list.get(i)
    selected_name = folder_list.get(i+1)
    selected_path = path + "/" + selected_name
    if (selected_file != 0) {
        selected_file.theme = ""
        if (file == selected_file) {
            // Clicked selected file
            selected_file = 0
            if (selected_type == _FOLDER) {
                load_path(window_i, path + "/" + folder_list.get(i+1))
            } elif (selected_type == _FILE) {
                file_clicked_open(list, selected_path, selected_name)
                list.set(6, 0)
            }
            return
        }
    }
    list.set(6, file) // selected_file
    file.theme = 0.2

    if (type == _SAVE) { return }

    // make bottom bar
    bottom_bar = list.get(4)
    bottom_bar.delete_children()
    rename = button("rename", "rename(" + window_i + ")")
    rename.size("fill")
    rename.margin(2)
    bottom_bar.add(rename)

    delete = button("delete", "delete(" + window_i + ")")
    delete.size("fill")
    delete.margin(2)
    bottom_bar.add(delete)

    extension = list.get(12)
    if (type == _NORMAL || (type == _OPEN && (selected_name.endswith(extension) || selected_type == _FOLDER))) {
        open = button("open", "open(" + window_i + ")")
        open.size("fill")
        open.margin(2)
        open.theme = "#FF4060"
        bottom_bar.add(open)
    }
}

def move_up(window_i) {
    path = windows_list.get(window_i).get(5)
    path_list = path.split("/")
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
    load_path(window_i, new_path)
}

def new_folder(window_i) {
    path = windows_list.get(window_i).get(5)
    os.add_folder(path, "New Folder")
    load_path(window_i, path)
}

def rename(window_i) {
    list = windows_list.get(window_i)

    path = list.get(5)
    folder_list = os.list_folder(path)
    selected_type = folder_list.get(list.get(9))
    selected_name = folder_list.get(list.get(9)+1)
    selected_path = path + "/" + selected_name

    selected_file = list.get(6)
    selected_file.delete_children()
    
    icon = costume()
    icon.scale = 8
    icon.size(15)
    icon.margin(2, "", 2, 2)
    selected_file.add(icon)

    rename_input = input(selected_name)
    rename_input.size("fill", "shrink")
    rename_input.margin(2, "", 0, 20)
    rename_input.onEnter = "renameEnter(" + window_i + ")"
    rename_input.focus()
    selected_file.add(rename_input)
    list.set(7, rename_input)
    
    if (selected_type == _FOLDER) {
        icon.costume = "filesystem//icon-folder"
    } elif (selected_type == _FILE) {
        if (selected_name.endswith(".img")) {
            icon.costume = "filesystem//icon-image"
        } elif (selected_name.endswith(".song")) {
            icon.costume = "filesystem//icon-music"
        } elif (selected_name.endswith(".app")) {
            icon.costume = "filesystem//icon-app"
        } else {
            icon.costume = "filesystem//icon-text"
        }
    }
}

def renameEnter(window_i) {
    list = windows_list.get(window_i)
    rename_text = list.get(7).text

    path = list.get(5)
    folder_list = os.list_folder(path)
    selected_type = folder_list.get(list.get(9))
    selected_name = folder_list.get(list.get(9)+1)
    selected_path = path + "/" + selected_name

    if (selected_type == _FOLDER) {
        os.rename_folder(selected_path, rename_text)
    } elif (selected_type == _FILE) {
        os.rename_file(selected_path, rename_text)
    }
    load_path(window_i, path)
}

def delete(window_i) {
    list = windows_list.get(window_i)

    path = list.get(5)
    folder_list = os.list_folder(path)
    selected_type = folder_list.get(list.get(9))
    selected_name = folder_list.get(list.get(9)+1)
    selected_path = path + "/" + selected_name

    if (selected_type == _FOLDER) {
        os.delete_folder(selected_path)
    } elif (selected_type == _FILE) {
        os.delete_file(selected_path)
    }
    load_path(window_i, path)
}

def open(window_i) {
    list = windows_list.get(window_i)
    type = list.get(0)

    path = list.get(5)
    folder_list = os.list_folder(path)
    selected_type = folder_list.get(list.get(9))
    selected_name = folder_list.get(list.get(9)+1)
    selected_path = path + "/" + selected_name
    
    if (selected_type == _FOLDER) {
        load_path(window_i, selected_path)
    } elif (selected_type == _FILE) {
        file_clicked_open(list, selected_path, selected_name)
    }
}

def file_clicked_open(list, selected_path, selected_name) {
    type = list.get(0)
    if (type == _OPEN) {
        os.run_code(list.get(13), list.get(14) + "(\"" + selected_path + "\")")
        list.get(1).delete()
    } elif (type == _NORMAL) {
        if (selected_name.endswith(".img")) {
            os.warn("There is no app to open image files")
        } elif (selected_name.endswith(".song")) {
            os.warn("There is no app to open song files")
        } elif (selected_name.endswith(".app")) {
            os.open_app(selected_name.slice(0,-4))
        } else {
            os.warn("There is no app to open text files")
        }
    }
}

def file_clicked_save(window_i) {
    list = windows_list.get(window_i)
    path = list.get(5)
    filename = list.get(17).text
    extension = list.get(12)
    data = list.get(18)
    if (!filename.endswith(extension)) {
        filename += extension
    }
    path += "/" + filename
    if (os.exists_path(path)) {
        os.error("path already exists")
        return
    }
    os.write_file(path, data)
    list.get(1).delete()
    list.set(0, _DELETED)
    update_all_windows()
}

def open_file(extension, path, callbackApp, callbackCode) {
    init_vars()
    list = create_window(_OPEN, path, extension, callbackApp, callbackCode)
}

def save_file(extension, path, data, callbackApp, callbackCode) {
    init_vars()
    list = create_window(_SAVE, path, extension, callbackApp, callbackCode)
    list.add(data)
}