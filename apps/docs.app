def init() {
    global headings = list()
    global contents = list()
    global texts = list()
    global tab = 0

    global window = window()
    window.center()
    window.minSize(180, 100)
    window.title = "RedScript Docs"

    global tabs = tabs()
    tabs.fill()
    tabs.margin(5)
    window.add(tabs)

    add_tab("Introduction")
    add_section(1, "Introduction", "This coding language was developed by KROKOBIL for Red OS 10 to easily create apps with dynamic layout. It is based on python, but it uses curly brackets. The language is compiled to a list of tokens that the project can easily execute.")
    add_section(1, "Hello World", "\\mdef init() {\\n    global window = window()\\n    window.center()\\n\\n    title = label(\"Hello World\", 20, 0.5)\\n    \\n    window.add(title)\\n}\\m")

    add_tab("Developement")
    add_section(1, "Developement", "All apps are in the \\mapps\\m folder. You can edit the \\m.app\\m files with any text editor. Run the \\mapps.convert.py\\m python file to generate \\mapps.preinstalled.txt\\m. Open the Scratch project and go to the \\mProgram\\m sprite. Show the \\mapps.preinstalled\\m list and import \\mapps.preinstalled.txt\\m. Restart the project.")

    add_tab("Data Types")
    add_section(1, "Variables", "A variable can be created and set like in python:\\mcount = 1\\nname = \"Scratch Cat\"\\ncount += 1\\m\\n\\nA variable is only defined inside the current function. If you want to create/set a global variable, use the \\mglobal\\m keyword. \\mglobal score = 0\\m")
    add_section(1, "Lists", "A list can be created with the \\mlist()\\m function. You can add any number of arguments: \\mlist(1, 2, 3, \"Hello World\")\\m. Lists can also contain other lists and elements.\\n\\nThe first element in a list has index 0.\\n\\nLists are just pointers to the actual list.\\n\\nAttributes:\\n- \\mlength\\m\\n\\nMethodes:\\n- \\mget(index)\\m returns the item at the given index\\n- \\mset(index, item)\\m or \\mreplace(index, item)\\m replaces the item at the given index\\n- \\madd(item)\\m or \\mappend(item)\\m adds an item to the end of the list\\n- \\minsert(item, index)\\m inserts an item before the item at the given index, so that it afterwards is at that index\\n- \\mdelete(index)\\m or \\mremove(index)\\m removes the item at the given index from the list\\n- \\mfind(item)\\m or \\mindex(item)\\m returns the index of the given item or -1 if it is not in the list\\n- \\mcopy()\\m returns a copy of the list (not a deep copy, so any item in the list is still the same)\\n- \\mjoin(separator)\\m returns a string of all elements")
    add_section(1, "Strings", "A string can be created with double quotation marks: \\m\"some text\"\\m.\\n\\nAttributes:\\n- \\mlength\\m\\n\\nMethodes:\\n- \\mget(index)\\m return the letter at that index, starting at 0\\n- \\mcontains(substring)\\m\\n- \\mbeginswith(prefix)\\m\\n- \\mendswith(suffix)\\m\\n- \\msplit(separator)\\m returns a list\\n- \\msplit_newline()\\m returns a list of the string splitted by actual new lines \\m\\\\n\\m, and not \\m\\\\\\\\n\\m\\n- \\mslice(start, end)\\m returns a string from start (inclusive) to end (exclusive)\\n\\n\\bText Formatting\\b\\n\\nStrings use the escape character \\m\\\\\\m. Since the program itself is a string, you have to double it: \\m\\\\\\\\\\m:\\n- \\m\"\\\\\\\\\\\\\\\\\"\\m -> \\m\\\\\\\\\\m -> \\m\\\\\\m\\n- \\m\"\\\\\\\\n\"\\m -> \\m\\\\n\\m -> new line\\n- \\m\"\\\\\\\\l\"\\m -> \\m\\\\l\\m -> \\l\\n- \\m\"\\\\\\\\m...\\\\\\\\m\"\\m -> \\m\\\\m...\\\\m\\m -> \\mmarker\\m\\n- \\m\"\\\\\\\\b...\\\\\\\\b\"\\m -> \\m\\\\b...\\\\b\\m -> \\\\bbold\\\\b\\n- \\m\"\\\\\\\\i...\\\\\\\\i\"\\m -> \\m\\\\i...\\\\i\\m -> \\\\iitalic\\\\i\\n- \\m\"\\\\\\\\u...\\\\\\\\u\"\\m -> \\m\\\\u...\\\\u\\m -> \\\\uunderline\\\\u\\n- \\m\"\\\\\\\\o...\\\\\\\\o\"\\m -> \\m\\\\o...\\\\o\\m -> \\m\\omonospace\\o\\m\\n\\ninternal:\\n- \\m\\\\s...\\\\s\\m -> \\mdisplay selected text\\m\\n- \\m\\\\c\\m -> display cursor")

    add_tab("Structures")
    add_section(1, "Comments", "You can write comments like this:\\n\\m// This is a comment\\n# This is also a comment\\m")
    add_section(1, "If", "\\mif (condition) {\\n    ...\\n} elif (condition) {\\n    ...\\n} elif (condition) {\\n    ...\\n} else (condition) {\\n    ...\\n}\\m")
    add_section(1, "While", "\\mwhile (condition) {\\n    ...\\n}\\m")
    add_section(1, "Functions", "\\mdef example(param1, param2) {\\n    return value\\n}\\n\\nexample(\"Hello\", \"World\")\\m")

    add_tab("Operators")
    add_section(1, "Operators", "Numbers:\\n- \\m+\\m addition\\n- \\m-\\m subtraction\\n- \\m*\\m multiplication\\n- \\m/\\m division\\n- \\m%\\m modulo\\n- \\m**\\m exponentiation\\n\\nStrings:\\n- \\m+\\m concatenation\\n\\nBooleans:\\n- \\m!\\m not\\n- \\m<<\\m left shift\\n- \\m>>\\m left shift\\n\\nRelational operators:\\n- \\m==\\m is equal to\\n- \\m!=\\m is not quual to\\n- \\m<\\m is less than\\n- \\m>\\m is greater than\\n- \\m<=\\m is less than or equal to\\n- \\m>=\\m is greater than or equal\\n\\nAssignment operators:\\n- \\m=\\m set variable to\\n- \\m+=\\m add to variable (also for strings)\\n- \\m-=\\m subtract from variable\\n- \\m*=\\m multiply variable by\\n- \\m/=\\m divide variable by")

    add_tab("Functions")
    add_section(1, "Functions", "The \\mcallback\\m parameter is the function name as a string, e.g. \\m\"example\"\\m.\\nThe \\monClick\\m, \\monEnter\\m, \\monClose\\m, ... parameter is code as a string, e.g. \\m\"example()\"\\m. This can be complex code.\\n\\nNumbers:\\n- \\mfloor(number)\\m\\n- \\mceil(number)\\m\\n- \\mround(number)\\m\\n- \\mabs(number)\\m absolute value\\n- \\msqrt(number)\\m square root\\n- \\msin(number)\\m sine in degrees\\n- \\mcos(number)\\m cosine in degrees\\n- \\mrand()\\m random number between 0 and 1\\n- \\mmax(number1, number2, ...)\\m maximum value\\n- \\mmin(number1, number2, ...)\\m minimum value\\n\\nType conversion:\\n- \\mstr(number)\\m\\n- \\mnumber(string)\\m\\n- \\mparse_digits(string)\\m returns a string with all non-digits removed\\n- \\mtype(something)\\m return \\m\"number\"\\m, \\m\"string\"\\m, \\m\"element\"\\m or \\m\"list\"\\m\\n\\nVariables:\\n- \\mexists(variable_name)\\m variable_name is a string")
    add_section(1, "System functions", "These functions are called by the os:\\n- \\minit()\\m when the program starts\\n- \\mframe()\\m every frame\\n- \\monClose()\\m when the program quits (when all windows are closed)")

    add_tab("Layout")
    add_section(1, "General", "- \\bCoordinates\\b start in the middle of the screen and get larger towards the right and bottom (unlike Scratch).\\n\\n- \\bsize\\b (width, height) of containers:\\n    - \\m\"fill\"\\m to expand as big as possible in the parent.\\n    - \\m\"shrink\"\\m to shrink as small as possible to the size of the children\\n    - number in pixels\\n\\n- \\bminimum size\\b (minWidth, minHeight):\\n    - \\m\"\"\\m for no minimum\\n    - number in pixels\\n\\n- \\bmargin\\b (marginTop, marginRight, marginBottom, marginLeft):\\n    - \\m\"\"\\m to expand the margin to fit the parent.\\n    - number in pixels\\n\\n    If opposite directions have the same margin value, the container is centered.\\n\\n- \\btheme\\b:\\n    - \\m0\\m for background color (white in light mode)\\n    - \\m1\\m for foreground color (black in light mode)\\n    -  number between 0 and 1 for a color between background and foreground (e.g. 0.2 to highlight a background box)\\n    - a color in hexadecimal (e.g. \\m\"0x123abc\"\\m or \\m\"#123abc\"\\m) or decimal (e.g. \\m1194684\\m)\\n\\n- \\balign\\b:\\n    - \\m0\\m for left\\n    - \\m1\\m for right\\n    - \\m0.5\\m for center\\n    - any other number\\n\\n- \\bwrap\\b:\\n    - \\m0\\m for one line without wrap\\n    - \\m1\\m for  multiple lines with wrap\\n\\n- \\bmode\\b of window:\\n    - \\m\"\"\\m\\n    - \\m\"no resize\"\\m\\n    - \\m\"camera\"\\m")
    add_section(0, "Element", "Methodes:\\n- \\madd(element)\\m adds another element as a child\\n- \\mdelete()\\m\\n- \\mdelete_children()\\m")
    add_section(0, "Window", "Inherited from \\mElement\\m\\n\\nConstructor:\\n- \\mwindow()\\m Creates a new 240\\i180 window\\n- \\mwindow(size)\\m size\\isize\\n- \\mwindow(width, height)\\m\\n\\nAttributes:\\n- \\mx\\m\\n- \\my\\m\\n- \\mwidth\\m\\n- \\mheight\\m\\n- \\mminWidth\\m\\n- \\mminHeight\\m\\n- \\mmode\\m\\n- \\mtitle\\m\\n- \\monClose\\m callback code\\n\\nMethodes:\\n- \\mpos(x, y)\\m\\n- \\msize(size)\\m size\\isize\\n- \\msize(width, height)\\m\\n- \\mminSize(size)\\m size\\isize\\n- \\mminSize(width, height)\\m\\n- \\mcenter()\\m\\n- \\mfocus()\\m")
    add_section(0, "Container", "Inherited from \\mElement\\m\\n\\nConstructor:\\n- \\mcontainer()\\m\\n\\nAttributes:\\n- \\mwidth\\m\\n- \\mheight\\m\\n- \\mminWidth\\m\\n- \\mminHeight\\m\\n- \\mmarginTop\\m\\n- \\mmarginRight\\m\\n- \\mmarginBottom\\m\\n- \\mmarginLeft\\m\\n- \\monClick\\m callback code\\n- \\mtheme\\m\\n\\nMethodes:\\n- \\msize(size)\\m size*size\\n- \\msize(width, height)\\m\\n- \\mfill()\\m set width and height to \\m\"fill\"\\m\\n- \\mshrink()\\m set width and height to \\m\"shrink\"\\m\\n- \\mmarginX(marginX)\\m set marginLeft and marginRight\\n- \\mmarginX(marginLeft, marginRight)\\m\\n- \\mmarginY(marginY)\\m set marginTop and marginBottom\\n- \\mmarginY(marginTop, marginBottom)\\m\\n- \\mmargin(margin)\\m\\n- \\mmargin(marginY, marginX)\\m\\n- \\mmargin(marginTop, marginX, marginBottom)\\m\\n- \\mmargin(marginTop, marginRight, marginBottom, marginLeft)\\m")
    add_section(0, "HContainer, VContainer", "Inherited from \\mContainer\\m\\n\\nConstructor:\\n- \\mhContainer()\\m\\n- \\mvContainer()\\m")
    add_section(0, "HScrollContainer, VScrollContainer", "Inherited from \\mContainer\\m\\n\\nConstructor:\\n- \\mhScrollContainer()\\m\\n- \\mvScrollContainer()\\m\\n\\nMethodes:\\n- \\mscrollDown()\\m for hContainer it scrolls to the right\\n- \\mscrollUp()\\m for hContainer it scrolls to the left")
    add_section(0, "Tabs", "Inherited from \\mContainer\\m\\n\\nConstructor:\\n- \\mtabs()\\m\\n\\nAttributes:\\n- \\mtab\\m index starting by 1 (0 for no tab)\\n- \\msideWidth\\m width of the left side of the tabs container\\n\\nMethodes:\\n- \\madd(element, tabName)\\m")
    add_section(0, "Label", "Inherited from \\mContainer\\m\\n\\nConstructor:\\n- \\mlabel()\\m\\n- \\mlabel(text)\\m\\n- \\mlabel(text, size)\\m\\n- \\mlabel(text, size, align)\\m\\n- \\mlabel(text, size, align, wrap)\\m\\n\\nAttributes:\\n- \\mtext\\m\\n- \\msize\\m Font size\\n- \\malign\\m\\n- \\mwrap\\m")
    add_section(0, "Input", "Inherited from \\mLabel\\m and \\mHScrollContainer\\m\\n\\nConstructor:\\n- \\minput()\\m\\n- \\minput(text)\\m\\n- \\minput(text, size)\\m\\n- \\minput(text, size, align)\\m\\n- \\minput(text, size, align, wrap)\\m\\n\\nAttributes:\\n- \\mfocus\\m if the input is selected, don't set it manually\\n- \\monEnter\\m callback code\\n\\nMethodes:\\n- \\mfocus()\\m\\n- \\mscrollDown()\\m for hContainer it scrolls to the right\\n- \\mscrollUp()\\m for hContainer it scrolls to the left")
    add_section(0, "Editor", "Inherited from \\mInput\\m and \\mVScrollContainer\\m\\n\\nConstructor:\\n- \\meditor()\\m\\n- \\meditor(text)\\m\\n- \\meditor(text, size)\\m\\n- \\meditor(text, size, align)\\m")
    add_section(0, "Button", "Inherited from \\mLabel\\m\\n\\nConstructor:\\n- \\mbutton()\\m\\n- \\mbutton(text)\\m\\n- \\mbutton(text, onClick)\\m")
    add_section(0, "Switch", "Inherited from \\mLabel\\m\\n\\nConstructor:\\n- \\mswitch()\\m\\n- \\mswitch(text)\\m\\n- \\mswitch(text, onClick)\\m\\n\\nAttrbutes:\\n- \\mstate\\m 0 or 1")
    add_section(0, "Slider", "Inherited from \\mLabel\\m\\n\\nConstructor:\\n- \\mslider()\\m\\n- \\mslider(value)\\m\\n- \\mslider(value, onSlide)\\m\\n\\nAttrbutes:\\n- \\mvalue\\m between 0 and 1\\n- \\monSlide\\m callback code")
    add_section(0, "Costume", "Inherited from \\mContainer\\m\\n\\nConstructor:\\n- \\mcostume()\\m\\n- \\mcostume(costume)\\m\\n- \\mcostume(costume, scale)\\m\\n\\nAttrbutes:\\n- \\mcostume\\m name of the costume in the \\mRender\\m sprite (can also be \\m\"#something\"\\m to draw something defined in Scratch: Render Sprite => Canvas Function)\\n- \\mscale\\m the displayed size is \\msize\\m * \\mscale\\m\\n- \\mdata\\m if you need to transfer some data to the canvas function in Scratch: Render Sprite => Canvas Function")

    add_tab("OS Interaction")
    add_section(1, "OS Interaction", "The os object has some attributes and methodes to interact with the project.")
    add_section(0, "Debugger", "- \\mos.print(text)\\m log to the debugger\\n- \\mos.warn(text)\\m log warning to the debugger\\n- \\mos.error(text)\\m log error to the debugger")
    add_section(0, "Apps", "- \\mos.run_code(app_name, code_string)\\m\\n- \\mos.calculate(expression_string, callback)\\m delay of one frame\\n- \\mos.open_app(app_name)\\m\\n- \\mos.compile_app(app_name)\\m compiles the file at \\mred_os/apps/app_name.app\\m")
    add_section(0, "Time", "- \\mos.year\\m\\n- \\mos.month\\m\\n- \\mos.date\\m\\n- \\mos.hour\\m\\n- \\mos.minute\\m\\n- \\mos.second\\m\\n- \\mos.millisecond\\m\\n- \\mos.time_str\\m the time as displayed on the desktop\\n- \\mos.time_seconds_str\\m the time as displayed on the desktop but with seconds\\n- \\mos.dayssince2000\\m\\n- \\mos.timezone\\m timezone as UTC offset\\n- \\mos.delta\\m time since the last frame in seconds\\n- \\mos.fps\\m returns frames per second of the OS")
    add_section(0, "Settings", "- \\mos.set_background(str)\\m or \\mos.set_wallpaper(str)\\m or \\mos.set_bg(str)\\m sets the wallpaper\\n- \\mos.set_theme(str)\\m sets the theme\\n- \\mos.set_volume(number)\\m sets the volume (0-100)\\n- \\mos.set_full_hours(number)\\m sets if 24-hour format should be used, 0 or 1\\n- \\mos.save_all(callback)\\m saves all settings to the server\\n- \\mos.full_hours\\m returns 0 or 1, if 1 the OS will display time in 24-hour format.\\n- \\mos.theme\\m returns \"Dark\", \"Light\", or \"Scheduled\"\\n- \\mos.theme_string\\m returns theme name, so \"dark\"\\n- \\mos.background\\m or \\mos.bg\\m returns wallpaper name (as of 2.10, \"BG1-3\")\\n- \\mos.volume\\m returns volume level\\n- \\mos.username\\m returns username of the current account\\n- \\mos.admin\\m returns 1 if user is admin\\n- \\mos.guest\\m returns 1 if user is guest\\n- \\mos.turbowarp\\m returns 1 if the project is running in Turbowarp")
    add_section(0, "Effects", "- \\mos.get_effect(number)\\m gets an effect value (0-1)\\n- \\mos.set_effect(number)\\m sets an effect value (0-1)\\n\\n\\bAvailable effects\\b\\n- \\m1\\m: Show FPS\\n- \\m2\\m: Show Delta\\n- \\m3\\m: Show AnimTime\\n- \\m4\\m: Show mouse trail\\n- \\m5\\m: Enable click effect\\n- \\m6\\m: Show seconds\\n- \\m7\\m: Show pre-installed apps list\\n\\nThese are the current effects as of v2.10. \\bDO NOT REORDER\\b, they rely on their index.")
    add_section(0, "Music", "- \\mos.music_start(song_id)\\m plays the song from the beginning\\n- \\mos.music_stop()\\m pauses the music\\n- \\mos.music_play()\\m continues the music\\n- \\mos.music_toggle()\\m pauses or continues the music\\n- \\mos.music_skip()\\m skips to the next song\\n- \\mos.music_skip_back()\\m skips to the last song\\n- \\mos.music_set_progress()\\m time in seconds\\n- \\mos.music_song_id\\m current song\\n- \\mos.music_progress\\m time in seconds\\n- \\mos.music_length\\m length of current song in seconds\\n- \\mos.music_name\\m name of current song\\n- \\mos.music_interpreter\\m interpreter of current song\\n- \\mos.music_is_playing\\m")
    add_section(0, "Sound", "- \\mos.start_sound(sound_name)\\m starts the sound in the audioRenderer sprite\\n- \\mos.stop_sound(sound_name)\\m stops the sound if it is playing")
    add_section(0, "Filesystem", "- \\mos.exists_path(path)\\m\\n- \\mos.read_file(path)\\m\\n- \\mos.write_file(path, content)\\m\\n- \\mos.delete_file(path)\\m\\n- \\mos.duplicate_file(path, new_name)\\m\\n- \\mos.move_file(path, to_folder)\\m\\n- \\mos.rename_file(path, new_name)\\m\\n- \\mos.list_folder(path)\\m returns a list\\n- \\mos.add_folder(path, name)\\m\\n- \\mos.delete_folder(path)\\m\\n- \\mos.duplicate_folder(path, new_name)\\m\\n- \\mos.move_folder(path, to_folder)\\m\\n- \\mos.rename_folder(path, new_name)\\m")
    add_section(0, "Cloud", "when finished the callback function is called\\n- \\mos.ask_draco(prompt, callback)\\m calls the local assistant\\n- \\mos.ask_llm(prompt, callback)\\m calls the large language model via python server and api\\n- \\mos.save_all(callback)\\m saves all settings to the server\\n- \\mos.search(query, callback)\\m searches duckduckgo\\n- \\mos.website(url, callback)\\m opens the url\\n- \\mos.appstore_get_all(callback)\\m returns a flat list [name, username, icon, ...]\\n- \\mos.appstore_get_requested(callback)\\m app that need to be reviewed by admins\\n- \\mos.appstore_get_app(app_name, callback)\\m returns parameters app_name, icon, code\\n- \\mos.appstore_get_requested_app(app_name, callback)\\m\\n- \\mos.appstore_approve_app(app_name, callback)\\m can only be called by admins, adds app to public apps\\n- \\mos.appstore_reject_app(app_name, callback)\\m can only be called by admins, removes app to requested apps\\n- \\mos.appstore_add(app_name, icon, code, callback)\\m adds or updates an existing app, needs to be reviewed")
    add_section(0, "Import and Export List", "- \\mos.show_list(list)\\m\\n- \\mos.hide_list()\\m\\n- \\moos.get_list()\\m\\n- \\moos.list_visible\\m")

}

def add_tab(name) {
    tab = vScrollContainer()
    tab.margin(5)
    tabs.add(tab, name)
}

def add_section(open, title, content) {
    heading = label("\\u" + title + "\\u", 15, 0)
    heading.marginY(5)
    heading.onClick = "toggle(" + headings.length + ")"
    tab.add(heading)
    headings.add(heading)

    body = label("", 10, 0, 1)
    if (open) {
        body.text = content
    }
    tab.add(body)
    contents.add(body)
    texts.add(content)
}

def toggle(index) {
    if (contents.get(index).text == "") {
        contents.get(index).text = texts.get(index)
    } else {
        contents.get(index).text = ""
    }
}
