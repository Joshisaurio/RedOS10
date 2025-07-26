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
    draco_window = window(340, 220)
    draco_window.center()
    draco_window.title = "Tips - Draco"

    draco_vbox = vScrollContainer()
    draco_vbox.fill()
    draco_vbox.margin(10)
    draco_window.add(draco_vbox)
    
    draco_title = label("\\bWhat is draco AI?\\b", 13)
    draco_vbox.add(draco_title)

    draco_content = "\\bDraco AI\\b is your personal assistant built right into \\bRed OS\\b, ready to help you out with just about anything. It runs in two powerful modes, depending on what you need:\\n\\bDraco Mode\\b\\nBuilt by the Red OS dev team from the ground up, this mode works similarly to Alexa, by using a token-based approach. In simple terms, it gets the keywords of what you said and responds accordingly. It\'s fast, simple, and doesn\'t rely on the internet. Use it for quick commands like \"open calendar,\" \"play music,\" or \"switch to dark mode.\"\\n\\bLLM Mode\\b\\nIn this mode, Draco connects to \\bLlama 4\\b, a large language model that\'s been trained with special context about \\bRed OS\\b and \\bOS Wars\\b - a Scratch-based battle to create the best custom OS. Use this mode when you want smarter, more in-depth help, or want to ask general knowledge questions. It\'s like having a genius in your taskbar. Keep in mind this mode requires you to log in for security reasons.\\n\\nSwitch between modes depending on whether you want raw speed or a nerd - Draco is flexible, friendly, and always at your service."
    draco_text = label(draco_content, 11)
    draco_text.wrap = 1
    draco_vbox.add(draco_text)
}

def create_how_window() {
    draco_window = window(340, 220)
    draco_window.center()
    draco_window.title = "Tips - How Red OS works"

    draco_vbox = vScrollContainer()
    draco_vbox.fill()
    draco_vbox.margin(10)
    draco_window.add(draco_vbox)
    
    draco_title = label("\\bHow does Red OS work?\\b", 13)
    draco_vbox.add(draco_title)

    draco_text = label("Red OS is one of the 4 OSes competing in OS Wars, made fully using Scratch 3.0 in 2025. Red OS works using the pen function and cloud variables. It draws everything that you see, from the taskbar to the windows in steps. As for the account system, it works by sending/receiving data from a server run by @KROKOBIL using cloud variables.", 11)
    draco_text.wrap = 1
    draco_vbox.add(draco_text)
}

def create_app_window() {
    draco_window = window(340, 220)
    draco_window.center()
    draco_window.title = "Tips - App tutorial"

    draco_vbox = vScrollContainer()
    draco_vbox.fill()
    draco_vbox.margin(10)
    draco_window.add(draco_vbox)
    
    draco_title = label("\\bMake your first Red OS app\\b", 13)
    draco_vbox.add(draco_title)

    app_content = "If you want to have a fun side project, you should try to create an app for Red OS! If you already know programming basics (especially Python), this shouldn't be too hard. But first, we need to understand how Red OS's programming language, Redscript works.\\n\\bA brief introduction to Redscript:\\b\\nThis coding language was developed by @KROKOBIL for Red OS 10 to easily create apps with dynamic layout. It is based on python, but it uses curly brackets. The language is compiled into a list of tokens that the project can easily execute.\\n\\n\\bHow to create your app file\\b\\nThere are 3 ways to create your app file:\\n\\b1. Use HyperText\\b\\nHyperText is the built-in text editor of Red OS. You can create a new .app file and name it however you want. I recommend that you click the \"Use template\" option to have an example piece of code. Use the textbox to write all your code. Once you're done, save it, and find it in the files app. It should be in the Hypertext folder. Now, just click run and see your app come to life!\\n\\b2. Use Visual Studio Code\\b\\nIf you already have Visual Studio Code installed, this is the best way to make apps for Red OS. For a more detailed explanation on how to use it for Red OS, please check the GitHub docs at https://github.com/Joshisaurio/RedOS10/blob/main/apps/README.md\\n\\b3. Use an external program\\b\\nYou can use any text editor, even the notepad, and copy down the code in Hypertext later to run your app.\\n\\n\\bHello World\\b\\nIt is a tradition for every programmer\'s first piece of code to print \"Hello world\" in the computer\'s console. Here is how you can do it in Red OS:\\n\\ndef init() {\\nglobal window = window()\\nwindow.center()\\n\\n\\ntitle = label(\"Hello World\", 20, 0.5)\\n\\nwindow.add(title)\\n}\\n\\nCopy the code above to Hyperscript. Once you're done, simply save the file, look for it in the filesystem, and then run it. You should see a window with the text \"Hello World\" show up in the center.\\n\\nCongratulations! You have just successfully created your first Red OS app.\\nIf this didn't work, double-check that you copied the code correctly. A misspelled word or letter could be causing the problem!\\nThis is just the tip of the iceberg of coding with Redscript. If you want to learn more, check the docs for a more detailed overview of the language."
    draco_text = label(app_content, 11)
    draco_text.wrap = 1
    draco_vbox.add(draco_text)
}

def create_quick_window() {
    draco_window = window(340, 220)
    draco_window.center()
    draco_window.title = "Tips - Quick actions"

    draco_vbox = vScrollContainer()
    draco_vbox.fill()
    draco_vbox.margin(10)
    draco_window.add(draco_vbox)
    
    draco_title = label("\\bHow to use Quick Actions\\b", 13)
    draco_vbox.add(draco_title)

    content = "Need to get something done fast? \\bQuick Actions\\b has you covered. It's a simple panel with handy shortcuts to common stuff you use all the time.\\n\\n\\bHow to open it:\\b\\nIn order to open Quick Actions, press and hold E. You will see a wheel of functions appear. Next, hover your mouse over your desired function. Finally, release the E key to perform your action.\\n\\n\\bHere's what each of the icons does:\\b\\n\\bClock\\b - Open the clock app to check the time, set alarms, or just stare at the ticking numbers.\\n\\bCalendar\\b - Open the calendar to see what day it is, check your events, or add new ones.\\n\\bSettings\\b - Open settings to tweak your system, personalize things, or fix whatever's bugging you.\\n\\bMusic\\b - Jump into your music player and vibe to your favorite tracks.\\n\\b+ Icon\\b - Drop a random icon onto your taskbar for fun\\n\\bTrash can\\b - Clean up your screen and remove all the extra random icons you added in one click.\\n\\bHalf-filled circle\\b - Switch between light and dark mode easily, on the go.\\n\\bDragon\\b - Launch Draco, the powerful built-in assistant.\\n\\nQuick Actions is all about speed and convenience, in order to improve your workflow. Try it right now!"
    draco_text = label(content, 11)
    draco_text.wrap = 1
    draco_vbox.add(draco_text)
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