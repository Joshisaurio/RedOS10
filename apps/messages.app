def init() {
    global window = window()
    window.minSize(300, 100)
    window.center()
    window.title = "Messages"

    tabs = tabs()
    window.add(tabs)

    inbox = container()
    tabs.add(inbox, "Inbox")

    global inbox_scroll = vScrollContainer()
    inbox.add(inbox_scroll)

    global inbox_labels = list()

    if (os.guest) {
        messages_loaded(list("\\iLogin to see your messages\\i"))
        return
    }

    messages_loaded(list("\\iLoading messages \\l\\i"))
    os.get_messages("messages_loaded")

    send = container()
    tabs.add(send, "Send")

    global send_editor = editor()
    send_editor.theme = 0.1
    send_editor.margin(30, 5, 30, 5)
    send_editor.onClick = "send_editor_click()"
    send.add(send_editor)

    send_label = label("The following text is sent to our team. Don't share any private or inappropriate information!")
    send_label.wrap = true
    send_label.margin(0, 5, "", 5)
    send.add(send_label)

    global send_button = button("send message", "send_message()")
    send_button.theme = "#FF4060"
    send_button.margin("", 5, 5, 5)
    send.add(send_button)

    global is_uploading = false
}

def frame() {
    if (!os.guest) {
        if (is_uploading == false) {
            if (send_editor.text.length > 10) {
                send_button.theme = "#FF4060"
            } else {
                send_button.theme = 0.2
            }
        }
    }
}

def send_message() {
    if (is_uploading == false && send_editor.text.length > 10) {
        is_uploading = true
        os.support_post(send_editor.text, "send_success")
        send_button.text = "\\l"
    }
}

def send_success() {
    send_button.text = "message sent"
    send_button.theme = "#52C832"
    send_editor.text = ""
    is_uploading = false
}

def send_editor_click() {
    if (is_uploading == false && send_button.text != "send message") {
        send_button.text = "send message"
        send_button.theme = "#FF4060"
    }
}

def messages_loaded(messages_list) {
    inbox_scroll.delete_children()
    inbox_labels = list()
    if (messages_list.length == 0) {
        messages_list.add("\\iNo messages\\i")
    }
    i = 0
    while (i < messages_list.length) {
        message_container = container()
        message_container.height = "shrink"
        message_container.onClick = "inbox_click(" + i + ")"
        message_container.margin(5)
        message_container.theme = 0.1
        message_label = label(messages_list.get(i), 8, 0, true)
        message_label.margin(5)
        message_container.add(message_label)
        inbox_scroll.add(message_container)
        inbox_labels.add(message_label)
        i += 1
    }
}

def inbox_click(i) {
    inbox_labels.get(i).wrap = !inbox_labels.get(i).wrap
}