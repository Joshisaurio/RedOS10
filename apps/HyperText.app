// vars "w_[window name]":                       windows
// vars "w_[window name]_main":                  window main container
// vars with "w_[window name]_[ui element name]: ui elements

def init() {
    global primary_color = "#FF4060"
    //#203EC7 is blue
    global background_brighter = "#1A1818"
    os.print("HyperText running")
    open_start_window()
}

def w_start_newfile() {
    open_newfile_window()
}
def w_start_openfile() {
    open_openfile_window
}
def w_newfile_filename_input(string) {
    w_editor_filename = string
}
def w_newfile_create() {
    os.print("Editor starting")
    w_start.delete_children()
    w_start.delete()
    w_newfile.delete_children()
    w_newfile.delete()
    open_editor_window()
}


def open_start_window() {
    global w_start = window(250, 310)
    w_start.center()
    w_start_main = container()

    w_start_recentlabel = title("Recent Files:")
    w_start_main.add(w_start_recentlabel)

    global w_start_recentfiles = vScrollContainer()
    w_start_recentfiles.margin(35, 10, 45)
    w_start_recentfiles.height = "fill"
    w_start_recentfiles.theme = background_brighter
    w_start_nofiles = label("No Recent Files")
    w_start_nofiles.margin(30)
    w_start_nofiles.align = 0.5
    w_start_recentfiles.add(w_start_nofiles)
    w_start_main.add(w_start_recentfiles)

    w_start_buttons = hcontainer()
    w_start_buttons.margin("", 10, 10)
    w_start_buttons.height = "shrink"
    w_start_new_button = button("New File", "w_start_newfile")
    w_start_new_button.marginRight = 5
    w_start_new_button.minHeight = 25
    w_start_new_button.theme = primary_color
    w_start_buttons.add(w_start_new_button)
    w_start_open_button = button("Open File", "w_start_openfile")
    w_start_open_button.marginLeft = 5
    w_start_open_button.theme = primary_color
    w_start_open_button.minHeight = 25
    w_start_buttons.add(w_start_open_button)
    w_start_main.add(w_start_buttons)

    w_start.add(w_start_main) 
}
def open_newfile_window() {
    global w_newfile = window(150, 160)
    w_newfile.center()

    w_newfile_main = container()
    w_newfile_createtitle = title("Create New File:")
    w_newfile_main.add(w_newfile_createtitle)

    w_newfile_templateswitchc = container()
    w_newfile_templateswitchc.margin(35, 10, "")
    w_newfile_templateswitchc.height = "shrink"
    w_newfile_templateswitchc.theme = background_brighter
    global w_newfile_templateswitch = switch("Use Template")
    w_newfile_templateswitch.margin(3, 8)
    w_newfile_templateswitchc.add(w_newfile_templateswitch)
    w_newfile_main.add(w_newfile_templateswitchc)

    w_newfile_filenamec = container()
    w_newfile_filenamec.margin(63, 10, "")
    w_newfile_filenamec.height = "shrink"
    w_newfile_filenamec.theme = background_brighter
    w_newfile_settingfilename = label("Filename", 9)
    w_newfile_settingfilename.margin(8, 8, "")
    w_newfile_filenamec.add(w_newfile_settingfilename)
    global w_editor_filename = "redos_app_" + round(rand() * 10000)
    w_newfile_filename = input(w_editor_filename, 10)
    w_newfile_filename.onEnter = "w_newfile_filename_input"
    w_newfile_filename.margin(20, 0, 4, 10)
    w_newfile_filenamec.add(w_newfile_filename)
    w_newfile_main.add(w_newfile_filenamec)

    w_newfile_filenameextra = label("(Filename extension will be .app)", 7)
    w_newfile_filenameextra.margin(110, 10, "")
    w_newfile_filenameextra.align = 0.5
    w_newfile_main.add(w_newfile_filenameextra)

    w_newfile_buttons = hcontainer()
    w_newfile_buttons.margin("", 10, 10)
    w_newfile_buttons.height = "shrink"
    w_newfile_create = button("Create", "w_newfile_create")
    w_newfile_create.marginRight = 2
    w_newfile_create.minHeight = 20
    w_newfile_create.theme = primary_color
    w_newfile_buttons.add(w_newfile_create)
    w_newfile_cancel = button("Cancel", "w_newfile_cancel")
    w_newfile_cancel.marginLeft = 2
    w_newfile_cancel.theme = primary_color
    w_newfile_cancel.minHeight = 20
    w_newfile_buttons.add(w_newfile_cancel)
    w_newfile_main.add(w_newfile_buttons)

    w_newfile.add(w_newfile_main)
}
def open_editor_window() {
    global w_editor = window(420, 300)
    w_editor.center()
    w_editor_tabs = tabs()

    w_editor_editmain = container()

    w_editor_editfiletitle = title("Edit " + w_editor_filename + ".app:")
    w_editor_editfiletitle.margin(10, 10, "")
    w_editor_editmain.add(w_editor_editfiletitle)

    w_editor_editscriptcontainer = container()
    w_editor_editscriptcontainer.margin(30, 10, 10)
    w_editor_editscriptcontainer.theme = background_brighter
    w_editor_editscriptcontainer.height = "fill"
    w_editor_editmain.add(w_editor_editscriptcontainer)

    w_editor_tabs.add(w_editor_editmain, "Edit " + w_editor_filename + ".app")

    w_editor_settingsmain = container()

    w_editor_tabs.add(w_editor_settingsmain, "Settings")

    w_editor.add(w_editor_tabs)

}

def title(text) {
    title = label(text, 15)
    title.margin(10, 10, "")
    return title
}

def onClose() {

}