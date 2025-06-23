def init() {
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

    addEventButton = button("New event", "add_event")
    addEventButton.marginRight = 2
    addEventButton.theme = "#FF4060"

    deleteAllEventsButton = button("Delete all", "delete_all_events")
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

    global daybox1 = container()
    global daybox2 = container()
    global daybox3 = container()
    global daybox4 = container()
    global daybox5 = container()
    global daybox6 = container()
    global daybox7 = container()

    dayboxContainer.add(daybox1)
    dayboxContainer.add(daybox2)
    dayboxContainer.add(daybox3)
    dayboxContainer.add(daybox4)
    dayboxContainer.add(daybox5)
    dayboxContainer.add(daybox6)
    dayboxContainer.add(daybox7)

    daybox1.marginTop = 0
    daybox2.marginTop = 0
    daybox3.marginTop = 0
    daybox4.marginTop = 0
    daybox5.marginTop = 0
    daybox6.marginTop = 0
    daybox7.marginTop = 0

    daybox1.height = 16
    daybox2.height = 16
    daybox3.height = 16
    daybox4.height = 16
    daybox5.height = 16
    daybox6.height = 16
    daybox7.height = 16

    global monthGrid = container()
    monthGrid.marginTop = 0
    tab_date_container.add(monthGrid)

    month_button_grid = hcontainer()
    month_button_grid.margin("", 4, 4, 4)
    month_button_grid.height = 20

    prevMonthButton = button("<", "prev_month")
    prevMonthButton.marginRight = 2
    prevMonthButton.theme = "#191919"

    nextMonthButton = button(">", "next_month")
    nextMonthButton.marginLeft = 2
    nextMonthButton.theme = "#191919"

    global jumpMonthNumber = label("January")
    jumpMonthNumber.align = 0.5

    month_button_grid.add(prevMonthButton)
    month_button_grid.add(jumpMonthNumber)
    month_button_grid.add(nextMonthButton)
    tab_date_container.add(month_button_grid)

    weekInitialContainer = hcontainer()
    weekInitialContainer.marginTop = 35
    tab_date_container.add(weekInitialContainer)

    global sunday = label("S", 12, 0.5)
    global monday = label("M", 12, 0.5)
    global tuesday = label("T", 12, 0.5)
    global wednesday = label("W", 12, 0.5)
    global thursday = label("T", 12, 0.5)
    global friday = label("F", 12, 0.5)
    global saturday = label("S", 12, 0.5)

    saturday.marginTop = 0
    friday.marginTop = 0
    thursday.marginTop = 0
    wednesday.marginTop = 0
    tuesday.marginTop = 0
    monday.marginTop = 0
    sunday.marginTop = 0

    weekInitialContainer.add(sunday)
    weekInitialContainer.add(monday)
    weekInitialContainer.add(tuesday)
    weekInitialContainer.add(wednesday)
    weekInitialContainer.add(thursday)
    weekInitialContainer.add(friday)
    weekInitialContainer.add(saturday)

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

    yearIncrease = button(">", "increment_year_jump")
    yearIncrease.marginLeft = 2
    yearDecrease = button("<", "decrement_year_jump")
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

    if (selectedMonth == 1) {
        month = "January"
        days = 31
    } elif (selectedMonth == 2) {
        month = "February"
        days = 28
    } elif (selectedMonth == 3) {
        month = "March"
        days = 31
    } elif (selectedMonth == 4) {
        month = "April"
        days = 30
    } elif (selectedMonth == 5) {
        month = "May"
        days = 31
    } elif (selectedMonth == 6) {
        month = "June"
        days = 30
    } elif (selectedMonth == 7) {
        month = "July"
        days = 31
    } elif (selectedMonth == 8) {
        month = "August"
        days = 31
    } elif (selectedMonth == 9) {
        month = "September"
        days = 30
    } elif (selectedMonth == 10) {
        month = "October"
        days = 31
    } elif (selectedMonth == 11) {
        month = "November"
        days = 30
    } elif (selectedMonth == 12) {
        month = "December"
        days = 31
    }

    global monthText = label("January", 18, 0.5)
    monthText.text = month + " " + selectedYear
    monthText.marginTop = 10

    tab_date_container.add(monthText)
    //tab_date_container.add(date)
    reloadMonth()
}

def frame() {
    date.text = month + " " + os.date + ", " + os.year

    //log.text = os.second
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
    if (selectedMonth == 1) {
        month = "January"
        days = 31
    } elif (selectedMonth == 2) {
        month = "February"
        days = 28
    } elif (selectedMonth == 3) {
        month = "March"
        days = 31
    } elif (selectedMonth == 4) {
        month = "April"
        days = 30
    } elif (selectedMonth == 5) {
        month = "May"
        days = 31
    } elif (selectedMonth == 6) {
        month = "June"
        days = 30
    } elif (selectedMonth == 7) {
        month = "July"
        days = 31
    } elif (selectedMonth == 8) {
        month = "August"
        days = 31
    } elif (selectedMonth == 9) {
        month = "September"
        days = 30
    } elif (selectedMonth == 10) {
        month = "October"
        days = 31
    } elif (selectedMonth == 11) {
        month = "November"
        days = 30
    } elif (selectedMonth == 12) {
        month = "December"
        days = 31
    }

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
        
        daybox1.theme = ""
        daybox2.theme = ""
        daybox3.theme = ""
        daybox4.theme = ""
        daybox5.theme = ""
        daybox6.theme = ""
        daybox7.theme = ""

        if (selectedMonth == os.month) {
            if (selectedYear == os.year) {
                dayboxContainer.marginTop = dateY - 4

                if (dateX == 1) {
                    daybox1.theme = "#191919"
                } elif (dateX == 2) {
                    daybox2.theme = "#191919"
                } elif (dateX == 3) {
                    daybox3.theme = "#191919"
                } elif (dateX == 4) {
                    daybox4.theme = "#191919"
                } elif (dateX == 5) {
                    daybox5.theme = "#191919"
                } elif (dateX == 6) {
                    daybox6.theme = "#191919"
                } elif (dateX == 7) {
                    daybox7.theme = "#191919"
                }
            }
        }
    }

    monthText.text = month + " " + selectedYear
    jumpMonthNumber.text = selectedMonth
    jumpYearNumber.text = selectedYear
    addMonthDays()
}

def addMonthDays() {
    monthOffset = getMonthStartDay(selectedMonth, selectedYear)

    i = 1 - monthOffset
    monthGrid.delete_children()

    daysOfMonthContainer1 = hcontainer()
    daysOfMonthContainer1.marginTop = 60
    monthGrid.add(daysOfMonthContainer1)
    
    while (i < 1) {
        day = label("", 10, 0.5)
        day.marginTop = 0

        daysOfMonthContainer1.add(day)
        i += 1
    }

    while (i < 8 - monthOffset) {
        day = label(i, 10, 0.5)
        day.marginTop = 0

        daysOfMonthContainer1.add(day)
        i += 1
    }


    daysOfMonthContainer2 = hcontainer()
    daysOfMonthContainer2.marginTop = 75
    monthGrid.add(daysOfMonthContainer2)
    while (i < 15 - monthOffset) {
        day = label(i, 10, 0.5)
        day.marginTop = 0

        daysOfMonthContainer2.add(day)
        i += 1
    }


    daysOfMonthContainer3 = hcontainer()
    daysOfMonthContainer3.marginTop = 90
    monthGrid.add(daysOfMonthContainer3)
    while (i < 22 - monthOffset) {
        day = label(i, 10, 0.5)
        day.marginTop = 0

        daysOfMonthContainer3.add(day)
        i += 1
    }


    daysOfMonthContainer4 = hcontainer()
    daysOfMonthContainer4.marginTop = 105
    monthGrid.add(daysOfMonthContainer4)
    while (i < 29 - monthOffset) {
        day = label(i, 10, 0.5)
        day.marginTop = 0

        daysOfMonthContainer4.add(day)
        i += 1
    }


    daysOfMonthContainer4 = hcontainer()
    daysOfMonthContainer4.marginTop = 120
    monthGrid.add(daysOfMonthContainer4)
    while (i < 36 - monthOffset) {
        if (i > days) {
            day = label("", 10, 0.5)
        } else {
            day = label(i, 10, 0.5)
        }
        day.marginTop = 0

        daysOfMonthContainer4.add(day)
        i += 1
    }


    daysOfMonthContainer5 = hcontainer()
    daysOfMonthContainer5.marginTop = 135
    monthGrid.add(daysOfMonthContainer5)
    while (i < 43 - monthOffset) {
        if (i > days) {
            day = label("", 10, 0.5)
        } else {
            day = label(i, 10, 0.5)
        }
        day.marginTop = 0

        daysOfMonthContainer5.add(day)
        i += 1
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