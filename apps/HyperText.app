// var "window":                                 window
// vars "w_[window name]_main":                  window main container
// vars with "w_[window name]_[ui element name]: ui elements


//on start of the app
def init() {
    global window = window(100, 150)

    //vars for smooth scaling
    global resize = true
    global target_size_x = 250
    global target_size_y = 310
    global actual_size_x = 100
    global actual_size_y = 150

    //color variables
    global primary_color = "#FF4060"
    global background_brighter = "#1A1818"

    os.print("HyperText running")
    open_start_window()
}
//every frame
def frame() {
    resize()
}

//set the resize paramters
def start_resize(size_x, size_y) {
    resize = true
    target_size_x = size_x
    target_size_y = size_y
}
//calculate and set the windows smooth size
def resize() {
    if (resize == true) {
        actual_size_x = actual_size_x + (target_size_x - actual_size_x) * 0.3
        actual_size_y = actual_size_y + (target_size_y - actual_size_y) * 0.3
        if (round(actual_size_x) == target_size_x) {
            actual_size_x = target_size_x
            if (round(actual_size_y) == target_size_y) {
                actual_size_y = target_size_y
                resize = false
            }
        }
        window.size(actual_size_x, actual_size_y)
        window.center()
    }
}

//when the newfile button is clicked in start window
def w_start_newfile() {
    open_newfile_window()
}
//when the openfile button is clicked in start window
def w_start_openfile() {
    open_openfile_window
}
//when the create buttons is clicked in newfile window
def w_newfile_create() {

    open_editor_window()
}

//the start window is opened when app is started
def open_start_window() {
    window.delete_children()
    start_resize(250, 310)
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

    window.add(w_start_main)
}
//the newfile window is opened when user wants to create a new file
def open_newfile_window() {
    window.delete_children()
    start_resize(155, 170)

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

    window.add(w_newfile_main)
}
//the real editor window
def open_editor_window() {
    window.delete_children()
    start_resize(435, 300)
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

    window.add(w_editor_tabs)
}

def title(text) {
    title = label(text, 15)
    title.margin(10, 10, "")
    return title
}

def onClose() {

}