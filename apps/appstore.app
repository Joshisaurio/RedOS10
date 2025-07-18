def init () {
    global window = window()
    window.center()
    window.minSize(180, 100)
    window.onClose = "window_closed()"

    global tabs = tabs()
    tabs.fill()
    tabs.sideWidth = 60

    global app_list_path = "red_os/system/appstore.txt"
    if (!os.exists_path(app_list_path)) {
        os.write_file(app_list_path, "")
    }
    global apps_list = os.read_file(app_list_path).split("\\n")
    if (apps_list.length == 1) {
        if (apps_list.get(0) == "") {
            apps_list.delete(0)
        }
    }

    ////// EXPLORE //////
    
    tab1 = container()
    tabs.add(tab1, "Explore")

    global explore_container = vScrollContainer()
    explore_container.margin(26, 5, 20, 5)
    tab1.add(explore_container)

    search_bar = container()
    search_bar.margin(0, 0, "", 0)
    search_bar.size("fill", 25)
    search_bar.theme = 0.2
    tab1.add(search_bar)

    search_bar_inner = container()
    search_bar_inner.margin(5)
    search_bar_inner.theme = 0
    search_bar.add(search_bar_inner)

    global search_input = input()
    search_input.theme = 0.05
    search_bar_inner.add(search_input)
    global loading_apps = true
    global last_search_input = search_input.text

    ////// UPLOAD //////

    if (!os.guest) {
        tab2 = container()
        tabs.add(tab2, "Upload")

        global upload_file_path = ""
        global upload_file_button = button("Select file", "upload_file_button_clicked()")
        upload_file_button.margin(5, "", "", 5)
        upload_file_button.width = 50
        upload_file_button.theme = "#FF4060"
        tab2.add(upload_file_button)

        global upload_file_label = label("\\iNo file selected\\i")
        upload_file_label.margin(8, 0, "", 60)
        tab2.add(upload_file_label)


        global upload_app_name_label = label("App name:", 10)
        upload_app_name_label.margin(30, 0, "", 5)
        tab2.add(upload_app_name_label)

        upload_app_name_container = container()
        upload_app_name_container.theme = 0.2
        upload_app_name_container.margin(28, 10, "", 60)
        upload_app_name_container.height = "shrink"
        global upload_app_name_input = input()
        upload_app_name_container.add(upload_app_name_input)
        tab2.add(upload_app_name_container)

        upload_username_label = label("Username: " + os.username, 10)
        upload_username_label.margin(50, 0, "", 5)
        tab2.add(upload_username_label)

        global upload_button = button("Upload", "upload()")
        upload_button.margin("", 10, 10, 10)
        upload_button.theme = 0
        tab2.add(upload_button)
        global can_upload = false
        global is_uploading = false
    }


    ////// EXPLORE //////
    
    if (os.admin) {
        tab3 = container()
        tabs.add(tab3, "Admin")
        tabs.tab = 3

        global admin_explore_container = vScrollContainer()
        admin_explore_container.margin(26, 5, 20, 5)
        tab3.add(admin_explore_container)

        admin_search_bar = container()
        admin_search_bar.margin(0, 0, "", 0)
        admin_search_bar.size("fill", 25)
        admin_search_bar.theme = 0.2
        tab3.add(admin_search_bar)

        admin_search_bar_inner = container()
        admin_search_bar_inner.margin(5)
        admin_search_bar_inner.theme = 0
        admin_search_bar.add(admin_search_bar_inner)

        global admin_search_input = input()
        admin_search_input.theme = 0.05
        admin_search_bar_inner.add(admin_search_input)
        global admin_loading_apps = true
        global admin_last_search_input = admin_search_input.text
    }
    global second_window = 0

    reload()

    window.add(tabs)
}

def frame() {
    if (!loading_apps && search_input.text != last_search_input) {
        search(search_input, all_apps, explore_container, "view_app")
        last_search_input = search_input.text
    }
    if (os.admin) {
        if (!admin_loading_apps && admin_search_input.text != admin_last_search_input) {
            search(admin_search_input, admin_all_apps, admin_explore_container, "admin_view_app")
            admin_last_search_input = admin_search_input.text
        }
    }
    if (!os.guest && tabs.tab == 2) {
        if (upload_file_path == "" || upload_app_name_input.text == "") {
            can_upload = false
            if (upload_button.text == "Upload") {
                upload_button.theme = 0
            }
        } else {
            can_upload = true
            upload_button.theme = "#FF4060"
            if (upload_button.text == "Uploaded successfully") {
                upload_button.text = "Upload"
            }
        }
    }
}

def reload() {
    if (second_window) {
        second_window.delete()
    }
    explore_container.delete_children()
    loading_label = label("\\iloading apps \\l\\i", 10, 0.5)
    loading_label.margin(30)
    explore_container.add(loading_label)

    global all_apps = list()
    os.appstore_get_all("all_apps_loaded")

    if (os.admin) {
        admin_explore_container.delete_children()
        admin_loading_label = label("\\iloading apps \\l\\i", 10, 0.5)
        admin_loading_label.margin(30)
        admin_explore_container.add(admin_loading_label)

        global admin_all_apps = list()
        os.appstore_get_requested("admin_all_apps_loaded")
    }
}

def all_apps_loaded(all_apps_new) {
    loading_apps = false
    all_apps = all_apps_new
    search(search_input, all_apps, explore_container, "view_app")
}

def admin_all_apps_loaded(admin_all_apps_new) {
    admin_loading_apps = false
    admin_all_apps = admin_all_apps_new
    search(admin_search_input, admin_all_apps, admin_explore_container, "admin_view_app")
}

def search(my_search_input, my_all_apps, my_explore_container, open_app_callback) {
    search_phrases = my_search_input.text.split()
    my_explore_container.delete_children()
    if (my_all_apps.length == 1) {
        error_label = label("\\ierror: " + my_all_apps.get(0) + "\\i", 10, 0.5, 1)
        error_label.margin(30)
        my_explore_container.add(error_label)
        return
    }
    i = 0
    while (i < my_all_apps.length) {
        app_name = my_all_apps.get(i)
        app_username = my_all_apps.get(i+1)
        app_icon = my_all_apps.get(i+2)

        if (matches_search(search_phrases, app_name + "  " + app_username)) {
            app_container = container()
            app_container.size("fill", 30)
            app_container.onClick = open_app_callback + "(" + i + ")"

            name_label = label("\\b" + app_name + "\\b")
            name_label.margin(5, 5, "", 30)
            app_container.add(name_label)

            username_label = label("by \\i" + app_username + "\\i", 8)
            username_label.margin("", 5, 3, 30)
            app_container.add(username_label)

            icon_costume = costume("icon//appstore", 5)
            icon_costume.margin(5, "", 5, 5)
            app_container.add(icon_costume)

            if (apps_list.find(app_name) > -1) {
                installed_costume = costume("other//installed", 10)
                installed_costume.size(10)
                installed_costume.margin(5, 5, 5, "")
                app_container.add(installed_costume)
            }

            my_explore_container.add(app_container)
        }
        i += 3
    }
}

def matches_search(search_phrases, item) {
    i = 0
    while (i < search_phrases.length) {
        if (!item.contains(search_phrases.get(i))) {
            return false
        }
        i += 1
    }
    return true
}

def upload_file_button_clicked() {
    root_path = "red_os/user/HyperText Documents"
    os.run_code("filesystem", "open_file(\".app\", \"" + root_path + "\", \"appstore\", \"upload_file_open_file\")")
}

def upload_file_open_file(path) {
    upload_file_path = path
    file_name = path.split("/").get(-1)
    upload_file_label.text = "\\i" + file_name + "\\i"
}

def upload() {
    if (can_upload && !is_uploading) {
        os.appstore_add(upload_app_name_input.text, "", os.read_file(upload_file_path), "upload_success")
        upload_button.text = "\\l"
        is_uploading = true
    }
}

def upload_success(response) {
    is_uploading = false
    if (response != "") {
        upload_button.text = response
        return
    }
    upload_button.text = "Uploaded successfully"
    upload_button.theme = "#52C832"
    upload_file_path = ""
    upload_file_label.text = "\\iNo file selected\\i"
    upload_app_name_input.text = ""
    if (os.admin) {
        reload()
    }
}

def view_app(i) {
    global second_window_app_name = all_apps.get(i)
    app_username = all_apps.get(i+1)
    app_icon = all_apps.get(i+2)
    if (second_window) {
        second_window.delete_children()
        second_window.focus()
        second_window.size(200, 100)
    } else {    
        second_window = window(200, 100)
        second_window.center()
    }
    second_window.title = second_window_app_name

    name_label = label("Install: \\b" + second_window_app_name + "\\b", 20)
    name_label.margin(10, 5, "", 45)
    second_window.add(name_label)

    icon_costume = costume("icon//appstore", 5)
    icon_costume.margin(5, "", "", 5)
    icon_costume.size(30)
    second_window.add(icon_costume)

    username_label = label("by \\i" + app_username + "\\i", 10)
    username_label.margin(45, 5, "", 8)
    second_window.add(username_label)

    buttons = hContainer()
    buttons.margin("", 2, 0, 2)
    second_window.add(buttons)

    global install_button = button("Install")
    install_button.margin("", 2, 5, 2)
    install_button.theme = "#FF4060"
    if (apps_list.find(second_window_app_name) > -1) {
        install_button.text = "Open"
        install_button.onClick = "os.open_app(\"" + second_window_app_name + "\")"
    } else {
        install_button.onClick = "install()"
    }
    buttons.add(install_button)
}

def admin_view_app(i) {
    global second_window_app_name = admin_all_apps.get(i)
    app_username = admin_all_apps.get(i+1)
    global second_window_app_icon = admin_all_apps.get(i+2)
    if (second_window) {
        second_window.delete_children()
        second_window.focus()
        second_window.size(200, 200)
    } else {    
        second_window = window(200, 200)
        second_window.center()
    }
    second_window.title = second_window_app_name

    name_label = label("Install: \\b" + second_window_app_name + "\\b", 20)
    name_label.margin(10, 5, "", 45)
    second_window.add(name_label)

    icon_costume = costume("icon//appstore", 5)
    icon_costume.margin(5, "", "", 5)
    icon_costume.size(30)
    second_window.add(icon_costume)

    username_label = label("by \\i" + app_username + "\\i", 10)
    username_label.margin(45, 5, "", 8)
    second_window.add(username_label)

    code_container = vScrollContainer()
    code_container.margin(60, 5, 30, 5)
    second_window.add(code_container)

    global code_label = label("\\iLoading App \\l\\i", 8, 0, 1)
    // code_label.monospace = true
    code_container.add(code_label)

    global buttons = hContainer()
    buttons.margin("", 2, 0, 2)
    second_window.add(buttons)

    global install_button = button("\\l")
    install_button.margin("", 2, 5, 2)
    install_button.theme = "#FF4060"
    buttons.add(install_button)

    global approve_button = button("\\l")
    approve_button.margin("", 2, 5, 2)
    approve_button.theme = "#52C832"
    buttons.add(approve_button)

    global reject_button = button("\\l")
    reject_button.margin("", 2, 5, 2)
    reject_button.theme = "#C83232"
    buttons.add(reject_button)

    os.appstore_get_requested_app(second_window_app_name, "admin_loaded")
}

def install() {
    os.appstore_get_app(second_window_app_name, "installed")
    install_button.text = "\\l"
    install_button.onClick = ""
}

def admin_install() {
    installed(second_window_app_name, second_window_app_icon, second_window_code)
}

def installed(app_name, icon, code) {
    install_button.text = "Open"
    install_button.onClick = "os.open_app(\"" + app_name + "\")"
    if (apps_list.find(app_name) == -1) {
        apps_list.add(app_name)
        os.write_file(app_list_path, apps_list.join("\\n"))
    }
    all_apps_loaded(all_apps)
    if (os.admin) {
        admin_all_apps_loaded(admin_all_apps)
    }
    os.write_file("red_os/apps/" + app_name + ".app", code)
    os.compile_app(app_name)
}

def admin_loaded(app_name, icon, code) {
    if (apps_list.find(app_name) > -1) {
        install_button.text = "installed"
        install_button.onClick = ""
    } else {
        install_button.text = "install"
        install_button.onClick = "admin_install()"
    }
    approve_button.text = "approve"
    approve_button.onClick = "admin_approve()"
    reject_button.text = "reject"
    reject_button.onClick = "admin_reject()"
    code_label.text = code
    global second_window_code = code
}

def admin_approve() {
    os.appstore_approve_app(second_window_app_name, "admin_approved")
    approve_button.text = "\\l"
}

def admin_approved() {
    approve_button.text = "approved"
    reload()
}

def admin_reject() {
    os.appstore_reject_app(second_window_app_name, "admin_rejected")
    reject_button.text = "\\l"
}

def admin_rejected() {
    reject_button.text = "rejected"
    reload()
}

def window_closed() {
    if (exists("second_window")) {
        if (second_window) {
            second_window.delete()
        }
    }
}