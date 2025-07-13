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

# Data Types

## Variables

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

## Lists

A list can be created with the `list()` function. You can add any number of arguments: `list(1, 2, 3, "Hello World")`. Lists can also contain other lists and elements.

The first element in a list has index 0.

Lists are just pointers to the actual list.

Attributes:
- `length`

Methodes:
- `get(index)` returns the item at the given index
- `set(index, item)` or `replace(index, item)` replaces the item at the given index
- `add(item)` or `append(item)` adds an item to the end of the list
- `insert(item, index)` inserts an item before the item at the given index, so that it afterwards is at that index
- `delete(index)` or `remove(index)` removes the item at the given index from the list
- `find(item)` or `index(item)` returns the index of the given item or -1 if it is not in the list
- `copy()` returns a copy of the list (not a deep copy, so any item in the list is still the same)

## Strings

A string can be created with double quotation marks: `"some text"`.

Attributes:
- `length`

Methodes:
- `get(index)` return the letter at that index, starting at 0
- `contains(substring)`
- `beginswith(prefix)`
- `endswith(suffix)`
- `split(separator)` returns a list
- `slice(start, end)` returns a string from start (inclusive) to end (exclusive)

### Text Formatting

Strings use the escape character `\`:
- `"\\"` -> `\`
- `"\n"` -> new line
- `"\l"` -> three animated dots
- `"\m...\m"` -> marker
- `"\b...\b"` -> **bold**
- `"\i...\i"` -> ***italic***
- `"\u...\u"` -> <ins>underline</ins>

internal:
- `\s...\s` -> display selected text
- `\c` -> display cursor

# Structures

## Comments

You can write comments like this:
```
// This is a comment
# This is also a comment
```

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

## While
```python
while (condition) {
    ...
}
```

## Functions
```python
def example(param1, param2) {
    return value
}

example("Hello", "World")
```

# Operators

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
- `type(something)` return `"number"`, `"string"`, `"element"` or `"list"`

Variables:
- `exists(variable_name)` variable_name is a string

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

- **mode** of window:
    - `""`
    - `"no resize"`
    - `"camera"`

## Element

Methodes:
- `add(element)` adds another element as a child
- `delete()`
- `delete_children()`

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
- `minWidth`
- `minHeight`
- `mode`
- `title`

Methodes:
- `pos(x, y)`
- `size(size)` size*size
- `size(width, height)`
- `minSize(size)` size*size
- `minSize(width, height)`
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

## HScrollContainer, VScrollContainer

Inherited from `Container`

Constructor:
- `hScrollContainer()`
- `vScrollContainer()`

Methodes:
- `scrollDown()` for hContainer it scrolls to the right
- `scrollUp()` for hContainer it scrolls to the left

## Tabs

Inherited from `Container`

Constructor:
- `tabs()`

Attributes:
- `tab` index starting by 1 (0 for no tab)
- `sideWidth` width of the left side of the tabs container

Methodes:
- `add(element, tabName)`

## Label

Inherited from `Container`

Constructor:
- `label()`
- `label(text)`
- `label(text, size)`
- `label(text, size, align)`
- `label(text, size, align, wrap)`

Attributes:
- `text`
- `size` Font size
- `align`
- `wrap`
- `monospace`

## Input

Inherited from `Label` and `HScrollContainer`

Constructor:
- `input()`
- `input(text)`
- `input(text, size)`
- `input(text, size, align)`
- `input(text, size, align, wrap)`

Attributes:
- `focus` if the input is selected, don't set it manually
- `onEnter` callback

Methodes:
- `focus()`
- `scrollDown()` for hContainer it scrolls to the right
- `scrollUp()` for hContainer it scrolls to the left

## Editor

Inherited from `Input` and `VScrollContainer`

Constructor:
- `editor()`
- `editor(text)`
- `editor(text, size)`
- `editor(text, size, align)`

## Button

Inherited from `Label`

Constructor:
- `button()`
- `button(text)`
- `button(text, onClick)`

## Switch

Inherited from `Label`

Constructor:
- `switch()`
- `switch(text)`
- `switch(text, onClick)`

Attrbutes:
- `state` 0 or 1

## Costume

Inherited from `Container`

Constructor:
- `costume()`
- `costume(costume)`
- `costume(costume, scale)`

Attrbutes:
- `costume` name of the costume in the `Render` sprite (can also be `"#something"` to draw something defined in Scratch: Render Sprite => Canvas Function)
- `scale` the displayed size is `size` * `scale`
- `data` if you need to transfer some data to the canvas function in Scratch: Render Sprite => Canvas Function

# OS Interaction

The os object has some attributes and methodes to interact with the project.

## Debugger
- `os.print(text)` log to the debugger
- `os.warn(text)` log warning to the debugger
- `os.error(text)` log error to the debugger

## Apps
- `os.run_code(app_name, code_string)`
- `os.calculate(expression_string, callback)` delay of one frame
- `os.open_app(app_name)`

## Time:
- `os.year`
- `os.month`
- `os.date`
- `os.hour`
- `os.minute`
- `os.second`
- `os.millisecond`
- `os.time_str` the time as displayed on the desktop
- `os.time_seconds_str` the time as displayed on the desktop but with seconds
- `os.dayssince2000`
- `os.timezone` timezone as UTC offset
- `os.delta` time since the last frame in seconds
- `os.fps` returns frames per second of the OS

## Settings
- `os.set_background(str)` or `os.set_wallpaper(str)` or `os.set_bg(str)` sets the wallpaper
- `os.set_theme(str)` sets the theme
- `os.set_volume(number)` sets the volume (0-100)
- `os.set_full_hours(number)` sets if 24-hour format should be used, 0 or 1
- `os.save_all(callback)` saves all settings to the server
- `os.full_hours` returns 0 or 1, if 1 the OS will display time in 24-hour format.
- `os.theme` returns "Dark", "Light", or "Scheduled"
- `os.theme_string` returns theme name, so "dark"
- `os.background` or `os.bg` returns wallpaper name (as of 2.10, "BG1-3")
- `os.volume` returns volume level
- `os.username` returns username of the current account
- `os.guest` returns 1 if user is guest
- `os.turbowarp` returns 1 if the project is running in Turbowarp

## Effects
- `os.get_effect(number)` gets an effect value (0-1)
- `os.set_effect(number)` sets an effect value (0-1)

### Available effects
- `1`: Show FPS
- `2`: Show Delta
- `3`: Show AnimTime
- `4`: Show mouse trail
- `5`: Enable click effect
- `6`: Show seconds
- `7`: Show pre-installed apps list

These are the current effects as of v2.10. **DO NOT REORDER**, they rely on their index.

## Music
- `os.music_start(song_id)` plays the song from the beginning
- `os.music_stop()` pauses the music
- `os.music_play()` continues the music
- `os.music_toggle()` pauses or continues the music
- `os.music_skip()` skips to the next song
- `os.music_skip_back()` skips to the last song
- `os.music_set_progress()` time in seconds
- `os.music_song_id` current song
- `os.music_progress` time in seconds
- `os.music_length` length of current song in seconds
- `os.music_name` name of current song
- `os.music_interpreter` interpreter of current song
- `os.music_is_playing`

## Cloud
when finished the callback function is called
- `os.ask_draco(prompt, callback)` calls the local assistant
- `os.ask_llm(prompt, callback)` calls the large language model via python server and api
- `os.save_all(callback)` saves all settings to the server
- `os.search(query, callback)` searches duckduckgo
- `os.website(url, callback)` opens the url

## Filesystem
- `os.exists_path(path)`
- `os.read_file(path)`
- `os.write_file(path, content)`
- `os.delete_file(path)`
- `os.duplicate_file(path, new_name)`
- `os.move_file(path, to_folder)`
- `os.rename_file(path, new_name)`
- `os.list_folder(path)` returns a list
- `os.add_folder(path, name)`
- `os.delete_folder(path)`
- `os.duplicate_folder(path, new_name)`
- `os.move_folder(path, to_folder)`
- `os.rename_folder(path, new_name)`
