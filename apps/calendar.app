def init() {
    global MONTHS_LIST = list("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")
    global DAYS_LIST = list(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
    global DAY_NAMES_LIST = list("S", "M", "T", "W", "T", "F", "S", "S")

    global window = window()
    window.center()

    tabs = tabs()
    tabs.fill()

    tabs.tab = 1

    tab1 = container()
    tabs.add(tab1, "Date")

    tab2 = container()
    tabs.add(tab2, "Events")
    events_label = label("Events", 12)
    events_label.margin(8, "", "", 8)
    tab2.add(events_label)

    global date = label("month", 10, 1)
    date.marginTop = 8
    date.marginright = 4

    global log = label("", 10, 0)
    log.marginTop = 80

    window.add(tabs)

    global tab_date_container = container()
    global tab_events_container = container()

    tab1.add(tab_date_container)
    tab2.add(tab_events_container)

    //- EVENTS -----------------------------------------------------/

    event_button_grid = hcontainer()
    event_button_grid.margin("", 4, 4, 4)
    event_button_grid.height = 20

    addEventButton = button("New event", "add_event()")
    addEventButton.marginRight = 2
    addEventButton.theme = "#FF4060"

    deleteAllEventsButton = button("Delete all", "delete_all_events()")
    deleteAllEventsButton.marginLeft = 2
    deleteAllEventsButton.theme = "#191919"

    event_button_grid.add(addEventButton)
    event_button_grid.add(deleteAllEventsButton)
    tab_events_container.add(event_button_grid)

    global events_list = vScrollContainer()
    events_list.marginTop = 30
    events_list.marginBottom = 20

    eventElement = container()
    eventElement.marginTop = 0
    eventElement.height = 18
    event_element_title = label("example event", 10, 0)
    event_element_title.marginTop = 0
    event_element_title.marginLeft = 8
    event_element_date = label("6/7/2025", 10, 1)
    event_element_date.marginRight = 8
    event_element_date.marginTop = 0
    eventElement.add(event_element_title)
    eventElement.add(event_element_date)

    events_list.add(eventElement)
    tab_events_container.add(events_list)

    event_name_container = container()
    event_name_container.marginLeft = 4
    event_name_container.marginRight = 4
    event_name_container.marginBottom = 26
    event_name_container.marginTop = ""
    event_name_container.height = 18
    event_name_container.theme = "#191919"
    global event_name_input = input("Event name")
    event_name_input.marginLeft = 4
    event_name_input.marginRight = 4
    event_name_container.add(event_name_input)
    tab_events_container.add(event_name_container)

    //- DATE -------------------------------------------------------/

    global dayboxContainer = hcontainer()
    dayboxContainer.marginTop = 25
    tab_date_container.add(dayboxContainer)

    global dayboxList = list()
    i = 0
    while (i < 7) {
        c = container()
        c.marginTop = 0
        c.height = 16
        dayboxContainer.add(c)
        dayboxList.add(c)
        i += 1
    }

    global monthGrid = container()
    monthGrid.marginTop = 0
    tab_date_container.add(monthGrid)

    month_button_grid = hcontainer()
    month_button_grid.margin("", 4, 4, 4)
    month_button_grid.height = 20

    prevMonthButton = button("<", "prev_month()")
    prevMonthButton.marginRight = 2
    prevMonthButton.theme = "#191919"

    nextMonthButton = button(">", "next_month()")
    nextMonthButton.marginLeft = 2
    nextMonthButton.theme = "#191919"

    global jumpMonthNumber = label("January()")
    jumpMonthNumber.align = 0.5

    month_button_grid.add(prevMonthButton)
    month_button_grid.add(jumpMonthNumber)
    month_button_grid.add(nextMonthButton)
    tab_date_container.add(month_button_grid)

    weekInitialContainer = hcontainer()
    weekInitialContainer.marginTop = 35
    tab_date_container.add(weekInitialContainer)

    global dayLabelList = list()
    i = 0
    while (i < 7) {
        dayLabel = label("", 12, 0.5)
        dayLabel.marginTop = 0
        weekInitialContainer.add(dayLabel)
        dayLabelList.add(dayLabel)
        i += 1
    }

    dateX = os.date-1%6
    dateX += 1
    dateY = 50
    if (os.date > 7) {
        dateY = 65
    } elif (os.date > 14) {
        dateY = 80
    } elif (os.date > 21) {
        dateY = 95
    } elif (os.date > 28) {
        dateY = 110
    }

    //------ JUMP TO YEAR

    jumpToContainer = hcontainer()
    jumpToContainer.margin("", 4, 24, 4)
    jumpToContainer.height = 20

    yearIncrease = button(">", "increment_year_jump()")
    yearIncrease.marginLeft = 2
    yearDecrease = button("<", "decrement_year_jump()")
    yearDecrease.marginRight = 2
    global jumpYearNumber = label("2025")
    jumpYearNumber.align = 0.5

    jumpToContainer.add(yearDecrease)
    jumpToContainer.add(jumpYearNumber)
    jumpToContainer.add(yearIncrease)

    tab_date_container.add(jumpToContainer)


    global month = "January"
    global days = 31

    global selectedMonth = os.month
    global selectedYear = os.year

    // january 1, 1970 is the beginning of time

    global monthText = label("", 18, 0.5)
    monthText.marginTop = 10

    tab_date_container.add(monthText)
    reloadMonth()
}

def frame() {
    if (startWeekOnSunday != os.get_effect(8)) {
        reloadMonth()
    }
    date.text = month + " " + os.date + ", " + os.year
}

def add_event() {
    eventElement = container()
    eventElement.marginTop = 0
    eventElement.height = 18
    event_element_title = label(event_name_input.text, 10, 0)
    event_element_title.marginTop = 0
    event_element_title.marginLeft = 8

    theOSdATE = os.month + "/" + os.date + "/" + os.year

    event_element_date = label(theOSdATE, 10, 1)
    event_element_date.marginRight = 8
    event_element_date.marginTop = 0
    eventElement.add(event_element_title)
    eventElement.add(event_element_date)

    events_list.add(eventElement)
    events_list.scrollDown()
}

def delete_all_events() {
    events_list.delete_children()
}

def next_month() {
    selectedMonth += 1
    if (selectedMonth == 13) {
        selectedMonth = 1
        selectedYear += 1
    }
    reloadMonth()
}

def prev_month() {
    selectedMonth -= 1
    if (selectedMonth == 0) {
        selectedMonth = 12
        selectedYear -= 1
    }
    reloadMonth()
}

def reloadMonth() {
    global startWeekOnSunday = os.get_effect(8)
    
    i = 0
    while (i < 7) {
        if (startWeekOnSunday) {
            dayLabelList.get(i).text = DAY_NAMES_LIST.get(i)
        } else {
            dayLabelList.get(i).text = DAY_NAMES_LIST.get(i+1)
        }
        i += 1
    }

    month = MONTHS_LIST.get(selectedMonth-1)
    days = DAYS_LIST.get(selectedMonth-1)

    //named like that because i already named a variable date
    dafe = os.date

    if (dafe < 32) {
        dateN1 = dafe-1
        dateX = dateN1%7
        dateX += 1
        dateY = 60
        if (dafe > 7) {
            dateY = 75
        }
        if (dafe > 14) {
            dateY = 90
        }
        if (dafe > 21) {
            dateY = 105
        }
        if (dafe > 28) {
            dateY = 120
        }
        if (dafe > 35) {
            dateY = 135
        }
        
        i = 0
        while (i < 7) {
            dayboxList.get(i).theme = ""
            i += 1
        }

        if (selectedMonth == os.month) {
            if (selectedYear == os.year) {
                dayboxContainer.marginTop = dateY - 4

                dayboxList.get(dateX).theme = "#191919"
            }
        }
    }

    monthText.text = month + " " + selectedYear
    jumpMonthNumber.text = selectedMonth
    jumpYearNumber.text = selectedYear
    addMonthDays()
}

def addMonthDays() {
    monthOffset = 1 - getMonthStartDay(selectedMonth, selectedYear) - startWeekOnSunday
    
    i = monthOffset

    monthGrid.delete_children()

    row = 0
    while (row < 5) {
        rowContainer = hcontainer()
        rowContainer.marginTop = 60 + 15 * row
        monthGrid.add(rowContainer)
        
        while (i < 1) {
            day = label("", 10, 0.5)
            day.marginTop = 0

            rowContainer.add(day)
            i += 1
        }

        while (i - monthOffset < 7 * (row+1)) {
            if (i > days) {
                day = label("", 10, 0.5)
            } else {
                day = label(i, 10, 0.5)
            }
            day.marginTop = 0

            rowContainer.add(day)
            i += 1
        }
        row += 1
    }
}

//ai generated function for javascript translated to red os app script
def getMonthStartDay(currentMonth, currentYear) {
    if (currentMonth < 3) {
        currentMonth += 12
        currentYear -= 1
    }

    k = currentYear % 100
    j = floor(currentYear / 100)

    // i do not understand this formula but I'm REALLY glad I didn't have to make this myself
    startDay = (1 + floor((13 * (currentMonth + 1)) / 5) + k + floor(k / 4) + floor(j / 4) - (2 * j)) % 7
    return ((startDay + 7) % 7) - 1
}

def increment_year_jump() {
    selectedYear += 1
    reloadMonth()
}

def decrement_year_jump() {
    selectedYear -= 1
    reloadMonth()
}