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
    row1.add(create_button("tips//quick", "How to use: Quick actions", "create_quick_window()"))
    row1.add(create_button("tips//how", "How it all works", "create_how_window()"))

    // SECOND ROW

    row2 = hContainer()
    row2.size("fill", "shrink")
    row2.margin(0)
    home_vbox.add(row2)
    row2.add(create_button("tips//draco", "What is Draco AI?", "create_draco_window()"))
    row2.add(create_button("tips//app", "How to create your own app", "create_app_window()"))
}

def create_draco_window() {
    create_window("Tips - Draco")

    add_section(1, "What is draco AI?", "\\bDraco AI\\b is your personal assistant built right into \\bRed OS\\b, ready to help you out with just about anything. It runs in two powerful modes, depending on what you need.")
    add_section(1, "Draco Mode", "Built by the Red OS dev team from the ground up, this mode works similarly to Alexa, by using a token-based approach. In simple terms, it gets the keywords of what you said and responds accordingly. It\'s fast, simple, and doesn\'t rely on the internet. Use it for quick commands like \"open calendar,\" \"play music,\" or \"switch to dark mode.\"")
    add_section(1, "LLM Mode", "In this mode, Draco connects to \\bLlama 3\\b, a large language model that\'s been trained with special context about \\bRed OS\\b and \\bOS Wars\\b - a Scratch-based battle to create the best custom OS. Use this mode when you want smarter, more in-depth help, or want to ask general knowledge questions. It\'s like having a genius in your taskbar. Keep in mind this mode requires you to log in for security reasons.\\n\\nSwitch between modes depending on whether you want raw speed or a nerd - Draco is flexible, friendly, and always at your service.")
}

def create_how_window() {
    create_window("Tips - How Red OS works")

    add_section(1, "Brief overview", "Red OS is one of the 4 OSes competing in OS Wars, made fully using Scratch 3.0 in 2025. Red OS works using the pen function and cloud variables. All apps are written in a text based programming language called RedScript.\\n\\n\\iClick the headings below to read more\\i")
    add_section(0, "How the OS renders things", "The project draws everything that you see, from the taskbar to the windows in steps. Every window is built of elements, whose size and position are calculated recursively, similar to HTML.")
    add_section(0, "How the OS sends-receives cloud data", "The cloud works by sending/receiving data from a server run by @KROKOBIL using cloud variables.")
    add_section(0, "How the account system works", "The server stores files containing all information about the project and its accounts. This data can only be seen by @KROKOBIL. The password is stored as a hash.")
    add_section(0, "Is the account system safe?", "The account system is pretty secure. The communication from the project to the server is encrypted with RSA-256, a simple version of what is used on the internet today. The communication from the server to the project is encrypted using a one-time pad with limited key size. Overall, the communication is not secure regarding modern standards, but Red OS has probably the best cloud encryption on scratch. Still don’t share any private or sensitive information!")
    add_section(0, "How the browser works", "If you enter an URL in the browser, it is sent to the server. The server opens the website and extracts readable text from the HTML. You can also use the search engine duckduckgo by just entering your search term. If you get an error message, try again later.")
    add_section(0, "How the app store works", "You can upload your own app to the app store. The app has to be revised by one of our admins before it is public to everyone.")
    add_section(0, "How the music system works", "The music system was created by @KROKOBIL and has two pretty amazing features: The lyrics of the song are synchronized for every word. And you can skip to any time almost instantly. This is achieved by splitting the song into 10 second long parts with some fading.")
    add_section(0, "How the programming language was made", "All apps are written in the programming language RedScript, developed by @KROKOBIL. The project compiles a text document using Reverse Polish Notation and a lot of complex logic for functions, if statements and while loops. You can write your own app in HyperText.")
}

def create_app_window() {
    create_window("Tips - App tutorial")

    add_section(1, "Make your first Red OS app", "If you want to have a fun side project, you should try to create an app for Red OS! If you already know programming basics (especially Python), this shouldn't be too hard. But first, we need to understand how Red OS's programming language, Redscript works.")
    add_section(1, "A brief introduction to Redscript", "This coding language was developed by @KROKOBIL for Red OS 10 to easily create apps with dynamic layout. It is based on python, but it uses curly brackets. The language is compiled into a list of tokens that the project can easily execute.")
    add_section(1, "Use HyperText", "HyperText is the built-in text editor of Red OS. You can create a new .app file and name it however you want. I recommend that you start with the template. Use the textbox to write all your code. Once you’re done, go to the Settings tab and click Compile and Run to see your app come to life! This button changes the app's code immediately. However, you may want to stop the app first to allow all changes to take effect.")
    add_section(1, "Export and Import", "In the settings tab you can also export your code. Click the Export button and right click the list that is shown and select Export. Save the file on your computer. You can also right click and select import to import a file from your computer. Click the button again to hide the list and import from the list if you uploaded anything. Important: Make sure that the imported file has no comma in the first line, just leave it empty to be safe!")
    add_section(1, "Use Visual Studio Code", "If you already have Visual Studio Code installed, this is the best way to make apps for Red OS. Install the extension RedScript by KROKOBIL. For a more detailed explanation on how to use it for Red OS, please check the docs app or GitHub docs at \\uhttps://github.com/Joshisaurio/RedOS10/blob/main/apps/README.md\\u")
    add_section(1, "Hello World", "It is a tradition for every programmer\'s first piece of code to print \"Hello world\" in the computer\'s console. Here is how you can do it in Red OS:\\n\\n\\mdef init() {\\nglobal window = window()\\nwindow.center()\\n\\ntitle = label(\"Hello World\", 20, 0.5)\\nwindow.add(title)\\n}\\m\\n\\nCopy the code above to Hyperscript. Once you're done, simply save the file, look for it in the filesystem, and then run it. You should see a window with the text \"Hello World\" show up in the center.\\n\\nCongratulations! You have just successfully created your first Red OS app.\\nIf this didn't work, double-check that you copied the code correctly. A misspelled word or letter could be causing the problem!\\nThis is just the tip of the iceberg of coding with Redscript. If you want to learn more, check the docs for a more detailed overview of the language.")
    add_button("Open the Red OS docs", "os.open_app(\"docs\")")
}

def create_quick_window() {
    create_window("Tips - Quick actions")

    add_section(1, "How to use Quick Actions", "Need to get something done fast? \\bQuick Actions\\b has you covered. It's a simple panel with handy shortcuts to common stuff you use all the time.")
    add_section(1, "How to open it", "In order to open Quick Actions, press and hold E. You will see a wheel of functions appear. Next, hover your mouse over your desired function. Finally, release the E key to perform your action.")
    add_section(1, "Here's what each of the icons does:", "\\b\\uClock\\u\\b - Open the clock app to check the time, set alarms, or just stare at the ticking numbers.\\n\\b\\uCalendar\\u\\b - Open the calendar to see what day it is, check your events, or add new ones.\\n\\b\\uSettings\\u\\b - Open settings to tweak your system, personalize things, or fix whatever's bugging you.\\n\\b\\uMusic\\u\\b - Jump into your music player and vibe to your favorite tracks.\\n\\b\\uTips\\u\\b - Open the tips app if you need help.\\n\\b\\uTrash can\\u\\b - Clean up your screen and minimize all open windows.\\n\\b\\uHalf-filled circle\\u\\b - Switch between light and dark mode easily, on the go.\\n\\b\\uDragon\\u\\b - Launch Draco, the powerful built-in assistant.\\n\\nQuick Actions is all about speed and convenience, in order to improve your workflow. Try it right now!")
}

def create_window(title) {
    global headings = list()
    global contents = list()
    global texts = list()

    if (!exists("window2")) {
        global window2 = window(340, 220)
        window2.center()
    } elif (type(window2) != "element") {
        window2 = window(340, 220)
        window2.center()
    }
    window2.title = title
    window2.delete_children()
    window2.focus()

    global vbox = vScrollContainer()
    vbox.fill()
    vbox.margin(10)
    window2.add(vbox)
}

def add_section(open, title, content) {
    heading = label("\\b\\u" + title + "\\u\\b", 12, 0)
    heading.marginY(5, 2)
    heading.onClick = "toggle(" + headings.length + ")"
    vbox.add(heading)
    headings.add(heading)

    body = label("", 10, 0, 1)
    if (open) {
        body.text = content
    }
    vbox.add(body)
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

def add_button(text, onClick) {
    my_button = button(text, onClick)
    my_button.marginY(5)
    my_button.theme = "#FF4060"
    vbox.add(my_button)
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