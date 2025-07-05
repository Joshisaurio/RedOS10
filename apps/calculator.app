def init() {
    global window = window()
    window.center()
    window.minSize(200, 200)

    input_bar = container()
    input_bar.margin(0, 0, "", 0)
    input_bar.size("fill", 25)
    input_bar.theme = 0.2
    window.add(input_bar)

    input_bar_inner = container()
    input_bar_inner.margin(5)
    input_bar_inner.theme = 0
    input_bar.add(input_bar_inner)

    global input = input()
    input.theme = 0.05
    input_bar_inner.add(input)

    global result = label()
    result.theme = 0.05
    result.align = 0.5
    result.size = 20
    result.margin(30, 5, "", 5)
    window.add(result)
}

def frame() {
    os.calculate(input.text, "display_result")
}

def display_result(result_text) {
    result.text = result_text
}