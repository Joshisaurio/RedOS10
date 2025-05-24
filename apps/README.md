# Coding Language

# Introduction

This coding language was developed by [KROKOBIL](https://github.com/kr0k0bil) for Red OS 10 to easily create apps with dynamic layout. It is based on python, but it uses curly brackets. The language is compiled to a list of tokens that the project can easily execute.

## Hello World

```python
def init() {
    global window = window()
    window.center()

    title = label("Hello World", 20, 0.5)
    
    window.add(title)
}
```

# Developement

All apps are in the `apps` folder. You can edit the `.app` files with any text editor. Run the `apps.convert.py` python file to generate `apps.preinstalled.txt`. Open the Scratch project and go to the `Program` sprite. Show the `apps.preinstalled` list and import `apps.preinstalled.txt`. Restart the project.

# Variables

A variable can be created and set like in python:
```python
count = 1
name = "Scratch Cat"
count += 1
```

A variable is only defined inside the current function. If you want to create/set a global variable, use the ```global``` keyword. 
```python
global score = 0
```

# Structures

## If
```python
if (condition) {
    ...
} elif (condition) {
    ...
} elif (condition) {
    ...
} else (condition) {
    ...
}
```

### While
```python
while (condition) {
    ...
}
```

### Functions
```python
def example(param1, param2) {
    return value
}

example("Hello", "World")
```

## Operators

Numbers:
- `+` addition
- `-` subtraction
- `*` multiplication
- `/` division
- `%` modulo
- `**` exponentiation

Strings:
- `+` concatenation

Booleans:
- `!` not
- `<<` left shift
- `>>` left shift

Relational operators:
- `==` is equal to
- `!=` is not quual to
- `<` is less than
- `>` is greater than
- `<=` is less than or equal to
- `>=` is greater than or equal

Assignment operators:
- `=` set variable to
- `+=` add to variable (also for strings)
- `-=` subtract from variable
- `*=` multiply variable by
- `/=` divide variable by

# Functions

The `callback` parameter is the function name as a string.

Numbers:
- `floor(number)`
- `ceil(number)`
- `round(number)`
- `abs(number)` absolute value
- `sqrt(number)` square root
- `sin(number)` sine in degrees
- `cos(number)` cosine in degrees
- `rand()` random number between 0 and 1
- `max(number1, number2, ...)` maximum value
- `min(number1, number2, ...)` minimum value

Type conversion:
- `str(number)`
- `number(string)`

## System functions

These functions are called by the os:
- `init()` when the program starts
- `frame()` every frame
- `onClose()` when the program quits (when all windows are closed)

# Layout

## General

- **Coordinates** start in the middle of the screen and get larger towards the right and bottom (unlike Scratch).

- **size** (width, height) of containers:
    - `"fill"` to expand as big as possible in the parent.
    - `"shrink"` to shrink as small as possible to the size of the children
    - number in pixels

- **minimum size** (minWidth, minHeight):
    - `""` for no minimum
    - number in pixels

- **margin** (marginTop, marginRight, marginBottom, marginLeft):
    - `""` to expand the margin to fit the parent.
    - number in pixels

    If opposite directions have the same margin value, the container is centered.

- **theme**:
    - `0` for background color (white in light mode)
    - `1` for foreground color (black in light mode)
    -  number between 0 and 1 for a color between background and foreground (e.g. 0.2 to highlight a background box)
    - a color in hexadecimal (e.g. `"0x123abc"` or `"#123abc"`) or decimal (e.g. `1194684`)

- **align**:
    - `0` for left
    - `1` for right
    - `0.5` for center
    - any other number

- **wrap**:
    - `0` for one line without wrap
    - `1` for  multiple lines with wrap

## Element

Methodes:
- `add(element)` adds another element as a child

## Window

Inherited from `Element`

Constructor:
- `window()` Creates a new 240*180 window
- `window(size)` size*size
- `window(width, height)`

Attributes:
- `x`
- `y`
- `width`
- `height`

Methodes:
- `pos(x, y)`
- `size(size)` size*size
- `size(width, height)`
- `center()`

## Container

Inherited from `Element`

Constructor:
- `container()`

Attributes:
- `width`
- `height`
- `minWidth`
- `minHeight`
- `marginTop`
- `marginRight`
- `marginBottom`
- `marginLeft`
- `onClick` callback function
- `theme`

Methodes:
- `size(size)` size*size
- `size(width, height)`
- `fill()` set width and height to `"fill"`
- `shrink()` set width and height to `"shrink"`
- `marginX(marginX)` set marginLeft and marginRight
- `marginX(marginLeft, marginRight)`
- `marginY(marginY)` set marginTop and marginBottom
- `marginY(marginTop, marginBottom)`
- `margin(margin)`
- `margin(marginY, marginX)`
- `margin(marginTop, marginX, marginBottom)`
- `margin(marginTop, marginRight, marginBottom, marginLeft)`

## HContainer, VContainer

Inherited from `Container`

Constructor:
- `hContainer()`
- `vContainer()`

Methodes:
- `scrollDown()` for hContainer it scrolls to the right
- `scrollUp()` for hContainer it scrolls to the left

## Label

Inherited from `Container`

Constructor:
- `label()`
- `label(text)`
- `label(text, fontSize)`
- `label(text, fontSize, align)`
- `label(text, fontSize, align, wrap)`

Attributes:
- `text`
- `fontSize`
- `align`
- `wrap`

Methodes:
- `scrollDown()` for hContainer it scrolls to the right
- `scrollUp()` for hContainer it scrolls to the left

## Input

Inherited from `Label` and `HContainer`

Constructor:
- `input()`
- `input(text)`
- `input(text, fontSize)`
- `input(text, fontSize, align)`
- `input(text, fontSize, align, wrap)`

Attributes:
- `focus` if the input is selected
- `onEnter` callback

Methodes:
- `scrollDown()` for hContainer it scrolls to the right
- `scrollUp()` for hContainer it scrolls to the left

## Costume

Inherited from `Container`

Constructor:
- `costume()`
- `costume(costume)`
- `costume(costume, scale)`

Attrbutes:
- `costume` name of the costume in the `Render` sprite
- `scale` the displayed size is `size` * `scale`

# OS Interaction

The os object has some attributes and methodes to interact with the project.

Attributes:
- `os.year`
- `os.month`
- `os.date`
- `os.hour`
- `os.minute`
- `os.second`
- `os.millisecond`
- `os.timestr` the time as displayed on the desktop
- `os.dayssince2000`
- `os.timezone` timezone as UTC offset

Methodes:
- `os.print(text)` log to the debugger
- `os.warn(text)` log warning to the debugger
- `os.error(text)` log error to the debugger
- `os.ask_draco(prompt, callback)` calls the local assistant, when finished the callback function is called
- `os.ask_llm(prompt, callback)` calls the large language model via python server and api, when finished the callback function is called
