def init() {
    global window = window()
    window.center()
    window.minSize(200, 200)

    search_bar = container()
    search_bar.margin(0, 0, "", 0)
    search_bar.size("fill", 25)
    search_bar.theme = 0.2
    window.add(search_bar)

    search_bar_inner = container()
    search_bar_inner.margin(5)
    search_bar_inner.theme = 0
    search_bar.add(search_bar_inner)

    global search_input = input()
    search_input.theme = 0.05
    search_input.onEnter = "on_enter()"
    search_bar_inner.add(search_input)

    global content = vScrollContainer()
    content.margin(26, 0, 0, 0)
    window.add(content)
}

def on_enter() {
    is_url = true
    if (search_input.text.contains(" ")) {
        is_url = false
    } elif (!search_input.text.contains(".")) {
        is_url = false
    } else {
        split = search_input.text.split(".")
        if (split.length < 2 || split.get(0).length == 0 || split.get(split.length-1).length == 0) {
            is_url = false
        }
    }
    if (is_url) {
        os.website(search_input.text, "display_website")
    } else {
        os.search(search_input.text, "display_results")
    }
}

def display_results(results) {
    if (results.length == 1) {
        display_website(results.get(0))
        return
    }
    content.delete_children()
    content.scrollUp()
    i = 0
    while (i < results.length) {
        title = results.get(i)
        url = results.get(i+1)
        preview = results.get(i+2)

        result_container = container()
        result_container.height = 20
        result_container.margin(3)
        result_container.theme = 0.1
        result_container.onClick = "click_link(\"" + url + "\")"
        
        title_label = label(title, 12)
        title_label.margin(3, 3, "", 3)
        result_container.add(title_label)

        preview_label = label(preview, 8, 0, 1)
        preview_label.margin(17, 3, "", 3)
        result_container.add(preview_label)
        
        content.add(result_container)
        i += 3
    }
}

def click_link(url) {
    search_input.text = url
    os.website(url, "display_website")
}

def display_website(text) {
    content.delete_children()
    content.scrollUp()
    
    text_label = label(text, 10)
    text_label.wrap = true
    text_label.margin(5)
    content.add(text_label)
}