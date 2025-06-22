def init() {
    global num_added_playlists = 0
    global window = window(400, 250)
    window.center()
    window.mode = "no resize"

    tabs = tabs()
    tabs.fill()
    tabs.tab = 1
    window.add(tabs)

    // Setup Tabs
    tab1 = container()
    tabs.add(tab1, "Home")
    tab2 = container()
    tabs.add(tab2, "Explore")
    tab3 = container()
    tabs.add(tab3, "Lyrics")
    tab4 = container()
    tabs.add(tab4, "Playlists")

    // --- Home Tab ---
    setup_home_tab(tab1)

    // --- Explore Tab ---
    setup_explore_tab(tab2)

    // --- Lyrics Tab ---
    setup_lyrics_tab(tab3)
    
    // --- Playlists Tab ---
    setup_playlists_tab(tab4)

    // --- Home Player Bar ---
    music_player = container()
    music_player.margin(225, 5, 5, 5)
    music_player.theme = "#1A1A1A"
    music_player.height = 20
    tab1.add(music_player)

    global play_symbol = costume("music//play", 5)
    play_symbol.margin(225, "", 5, 250)
    play_symbol.size(15)
    play_symbol.onClick = "start_music"
    tab1.add(play_symbol)

    global skip_back = costume("music//skip_back", 5)
    skip_back.margin(225, "", 5, 230)
    skip_back.size(15)
    skip_back.onClick = "skip_b_music"
    tab1.add(skip_back)

    global skip_forward = costume("music//skip_forward", 5)
    skip_forward.margin(225, "", 5, 270)
    skip_forward.size(15)
    skip_forward.onClick = "skip_f_music"
    tab1.add(skip_forward)

    global song_picture_small = costume("music//viva-la-vida", 4)
    song_picture_small.margin("", "", 14, 15)
    song_picture_small.size(1)
    tab1.add(song_picture_small)

    global songname_printed = label("Viva la Vida", 8)
    songname_printed.margin("", 180, 10, 30)
    tab1.add(songname_printed)

    global interpreter_printed = label("Coldplay", 5)
    interpreter_printed.margin("", "", 6, 30)
    tab1.add(interpreter_printed)

    global song_progress = label("0:00", 5)
    song_progress.margin("","", 13, 120)
    tab1.add(song_progress)

    global song_length = label("4:03", 5)
    song_length.margin("", "", 13, 210)
    tab1.add(song_length)

    global song_bar = costume("#song")
    song_bar.margin(240, 120)
    tab1.add(song_bar)

    // --- Explore Player Bar ---
    music_player2 = container()
    music_player2.margin(225, 5, 5, 5)
    music_player2.theme = "#1A1A1A"
    music_player2.height = 20
    tab2.add(music_player2)

    global play_symbol2 = costume("music//play", 5)
    play_symbol2.margin(225, "", 5, 255)
    play_symbol2.size(15)
    play_symbol2.onClick = "start_music"
    tab2.add(play_symbol2)

    global skip_back2 = costume("music//skip_back", 5)
    skip_back2.margin(225, "", 5, 235)
    skip_back2.size(15)
    skip_back2.onClick = "skip_b_music"
    tab2.add(skip_back2)

    global skip_forward2 = costume("music//skip_forward", 5)
    skip_forward2.margin(225, "", 5, 275)
    skip_forward2.size(15)
    skip_forward2.onClick = "skip_f_music"
    tab2.add(skip_forward2)
    
    global song_picture_small2 = costume("music//viva-la-vida", 4)
    song_picture_small2.margin("", "", 14, 20)
    song_picture_small2.size(1)
    tab2.add(song_picture_small2)
    
    global songname_printed2 = label("Viva la Vida", 8)
    songname_printed2.margin("", 180, 10, 30)
    tab2.add(songname_printed2)
    
    global interpreter_printed2 = label("Coldplay", 5)
    interpreter_printed2.margin("", "", 6, 35)
    tab2.add(interpreter_printed2)
    
    global song_progress2 = label("0:00", 5)
    song_progress2.margin("","", 13, 125)
    tab2.add(song_progress2)
    
    global song_length2 = label("4:03", 5)
    song_length2.margin("", "", 13, 215)
    tab2.add(song_length2)
    
    global song_bar2 = costume("#song")
    song_bar2.margin(240, 120)
    tab2.add(song_bar2)

    // --- Lyrics Player Bar ---
    music_player3 = container()
    music_player3.margin(225, 5, 5, 5)
    music_player3.theme = "#1A1A1A"
    music_player3.height = 20
    tab3.add(music_player3)

    global play_symbol3 = costume("music//play", 5)
    play_symbol3.margin(225, "", 5, 250)
    play_symbol3.size(15)
    play_symbol3.onClick = "start_music"
    tab3.add(play_symbol3)

    global skip_back3 = costume("music//skip_back", 5)
    skip_back3.margin(225, "", 5, 230)
    skip_back3.size(15)
    skip_back3.onClick = "skip_b_music"
    tab3.add(skip_back3)

    global skip_forward3 = costume("music//skip_forward", 5)
    skip_forward3.margin(225, "", 5, 270)
    skip_forward3.size(15)
    skip_forward3.onClick = "skip_f_music"
    tab3.add(skip_forward3)
    
    global song_picture_small3 = costume("music//viva-la-vida", 4)
    song_picture_small3.margin("", "", 14, 15)
    song_picture_small3.size(1)
    tab3.add(song_picture_small3)
    
    global songname_printed3 = label("Viva la Vida", 8)
    songname_printed3.margin("", 180, 10, 30)
    tab3.add(songname_printed3)
    
    global interpreter_printed3 = label("Coldplay", 5)
    interpreter_printed3.margin("", "", 6, 30)
    tab3.add(interpreter_printed3)
    
    global song_progress3 = label("0:00", 5)
    song_progress3.margin("","", 13, 120)
    tab3.add(song_progress3)
    
    global song_length3 = label("4:03", 5)
    song_length3.margin("", "", 13, 210)
    tab3.add(song_length3)
    
    global song_bar3 = costume("#song")
    song_bar3.margin(240, 120)
    tab3.add(song_bar3)
    
    // --- Playlists Player Bar ---
    music_player4 = container()
    music_player4.margin(225, 5, 5, 5)
    music_player4.theme = "#1A1A1A"
    music_player4.height = 20
    tab4.add(music_player4)

    global play_symbol4 = costume("music//play", 5)
    play_symbol4.margin(225, "", 5, 250)
    play_symbol4.size(15)
    play_symbol4.onClick = "start_music"
    tab4.add(play_symbol4)

    global skip_back4 = costume("music//skip_back", 5)
    skip_back4.margin(225, "", 5, 230)
    skip_back4.size(15)
    skip_back4.onClick = "skip_b_music"
    tab4.add(skip_back4)

    global skip_forward4 = costume("music//skip_forward", 5)
    skip_forward4.margin(225, "", 5, 270)
    skip_forward4.size(15)
    skip_forward4.onClick = "skip_f_music"
    tab4.add(skip_forward4)
    
    global song_picture_small4 = costume("music//viva-la-vida", 4)
    song_picture_small4.margin("", "", 14, 15)
    song_picture_small4.size(1)
    tab4.add(song_picture_small4)
    
    global songname_printed4 = label("Viva la Vida", 8)
    songname_printed4.margin("", 180, 10, 30)
    tab4.add(songname_printed4)
    
    global interpreter_printed4 = label("Coldplay", 5)
    interpreter_printed4.margin("", "", 6, 30)
    tab4.add(interpreter_printed4)
    
    global song_progress4 = label("0:00", 5)
    song_progress4.margin("","", 13, 120)
    tab4.add(song_progress4)
    
    global song_length4 = label("4:03", 5)
    song_length4.margin("", "", 13, 210)
    tab4.add(song_length4)
    
    global song_bar4 = costume("#song")
    song_bar4.margin(240, 120)
    tab4.add(song_bar4)

    global progress = os.music_progress_skip
}

def setup_home_tab(tab) {
    home_vbox = vScrollContainer()
    home_vbox.margin(60, 5, 60, 5)
    tab.add(home_vbox)

    news_container = container()
    news_container.margin(0,10,"", 10)
    news_container.height = 75
    news_container.onClick = "gladius"
    home_vbox.add(news_container)  

    news = costume("music//news",10)
    news.margin("","","","")
    news.size(7)
    news_container.add(news)

    // Horizontal song recommendation lists
    song_shown_first = hScrollContainer()
    song_shown_first.margin(15,10,"", 10)
    song_shown_first.height = 75
    home_vbox.add(song_shown_first)  
    
    add_song_preview(song_shown_first, "diamond-heart", "diamond_heart")
    add_song_preview(song_shown_first, "lost", "lost")
    add_song_preview(song_shown_first, "never-gonna-give-you-up", "never_gonna_give_you_up")

    song_shown_first2 = hScrollContainer()
    song_shown_first2.margin(5,10,"", 10)
    song_shown_first2.height = 75
    home_vbox.add(song_shown_first2)

    add_song_preview(song_shown_first2, "hall-of-fame", "hall_of_fame")
    add_song_preview(song_shown_first2, "hotel-california", "hotel_california")
    add_song_preview(song_shown_first2, "call-of-the-wild", "call_of_the_wild")

    home_vbox.scrollUp()
}

def setup_explore_tab(tab) {
    explore_scroll = vScrollContainer()
    explore_scroll.margin(40, 5, 60, 5)
    tab.add(explore_scroll)

    // Add all the songs to the explore list
    create_song_entry(explore_scroll, "viva-la-vida", "viva la vida", "Coldplay", "viva_la_vida")
    create_song_entry(explore_scroll, "hotel-california", "hotel california", "Eagles", "hotel_california")
    create_song_entry(explore_scroll, "lost", "lost", "Linkin Park", "lost")
    create_song_entry(explore_scroll, "nothing-else-matters", "nothing else matters", "Metallica", "nothing_else_matters")
    create_song_entry(explore_scroll, "somewhere-i-belong", "somewhere i belong", "Linkin Park", "somewhere_i_belong")
    create_song_entry(explore_scroll, "everything-ends", "everything ends", "Architects", "everything_ends")
    create_song_entry(explore_scroll, "hall-of-fame", "hall of fame", "The Script", "hall_of_fame")
    create_song_entry(explore_scroll, "call-of-the-wild", "call of the wild", "Powerwulf", "call_of_the_wild")
    create_song_entry(explore_scroll, "diamond-heart", "diamond heart", "Alan Walker", "diamond_heart")
    create_song_entry(explore_scroll, "never-gonna-give-you-up", "never gonna give you up", "Rick Astley", "never_gonna_give_you_up")
    create_song_entry(explore_scroll, "above-the-skies", "Above the skies", "RedOS-Paulottix", "above_the_skies")
    create_song_entry(explore_scroll, "legends", "legends", "RedOS-Paulottix", "legends")
    create_song_entry(explore_scroll, "gladius", "Gladius Superabit", "Paulottix,SunoAi,Citrus", "gladius")
    create_song_entry(explore_scroll, "mountains", "where the mountain ends", "RedOS-Paulottix", "mountain")
    create_song_entry(explore_scroll, "where_the_mountain_ends_progressive_house_version", "Where the m. ends ph", "RedOS-Paulottix", "mountain_ends")
    create_song_entry(explore_scroll, "no", "No Return", "RedOS-Paulottix", "no")
    create_song_entry(explore_scroll, "that-bass", "That Bass will grow on you ig", "RedOS-Paulottix", "that_bass")
    create_song_entry(explore_scroll, "gladius-superabit-v2", "Gladius Superabit v2", "RedOS-Paulottix", "gladius_superabit")
}

def setup_lyrics_tab(tab) {
    lyrics_container = vScrollContainer()
    lyrics_container.margin(30, 5, 60, 5)
    tab.add(lyrics_container)
    
    os.music_get_line()

    global lyrics_word1 = create_lyrics_line(lyrics_container, " ", "lyrics1")
    global lyrics_word2 = create_lyrics_line(lyrics_container, " ", "lyrics2")
    global lyrics_word3 = create_lyrics_line(lyrics_container, "Please start a song", "lyrics3")
    global lyrics_word4 = create_lyrics_line(lyrics_container, " ", "lyrics4")
    global lyrics_word5 = create_lyrics_line(lyrics_container, " ", "lyrics5")
    
    lyrics_container.scrollUp()
}

def setup_playlists_tab(tab) {
    global playlists_vbox = vScrollContainer()
    playlists_vbox.margin(60, 5, 60, 5)
    tab.add(playlists_vbox)

    add_button = button("Add New Playlist", "add_playlist_clicked")
    add_button.height = 20
    add_button.margin(0, 5, 5, 5)
    playlists_vbox.add(add_button)

    global playlist_row_1 = hScrollContainer()
    playlist_row_1.margin(15,10,"", 10)
    playlist_row_1.height = 75
    playlists_vbox.add(playlist_row_1)

    add_playlist_preview(playlist_row_1, "music//lost", "open_pop_playlist")
    add_playlist_preview(playlist_row_1, "music//no", "open_rock_playlist")
    add_playlist_preview(playlist_row_1, "music//never-gonna-give-you-up", "open_rick_playlist")
}

def frame() {
    if (os.music_is_playing) {
        play_symbol.costume = "music//pause"
        play_symbol2.costume = "music//pause"
        play_symbol3.costume = "music//pause"
        play_symbol4.costume = "music//pause"
    } else {
        play_symbol.costume = "music//play"
        play_symbol2.costume = "music//play"
        play_symbol3.costume = "music//play"
        play_symbol4.costume = "music//play"
    }
    
    // Home player
    song_progress.text = format_time(os.music_progress)
    song_length.text = format_time(os.music_length)
    song_bar.data = os.music_progress / os.music_length
    songname_printed.text = os.music_name
    interpreter_printed.text = os.music_interpreter
    song_picture_small.costume = "music//" + os.music_song_id
    
    // Explore player
    song_progress2.text = format_time(os.music_progress)
    song_length2.text = format_time(os.music_length)
    song_bar2.data = os.music_progress / os.music_length
    songname_printed2.text = os.music_name
    interpreter_printed2.text = os.music_interpreter
    song_picture_small2.costume = "music//" + os.music_song_id
    
    // Lyrics player
    song_progress3.text = format_time(os.music_progress)
    song_length3.text = format_time(os.music_length)
    song_bar3.data = os.music_progress / os.music_length
    songname_printed3.text = os.music_name
    interpreter_printed3.text = os.music_interpreter
    song_picture_small3.costume = "music//" + os.music_song_id

    // Playlists player
    song_progress4.text = format_time(os.music_progress)
    song_length4.text = format_time(os.music_length)
    song_bar4.data = os.music_progress / os.music_length
    songname_printed4.text = os.music_name
    interpreter_printed4.text = os.music_interpreter
    song_picture_small4.costume = "music//" + os.music_song_id

    if (os.music_is_playing) {
        lyrics_word1.text = os.music_text1
        lyrics_word2.text = os.music_text2
        lyrics_word3.text = os.music_text3
        lyrics_word4.text = os.music_text4
        lyrics_word5.text = os.music_text5
    }

    global progress = os.music_progress_skip
    if(os.mps_skip_status == 1){
        os.music_set_progress(progress)
        os.music_play()
    }
}

// ---------------------------------------------------
// --              REUSABLE HELPER FUNCTIONS        --
// ---------------------------------------------------

def create_song_entry(parent, song_id, song_title, interpreter, on_click_handler) {
    // Creates a single song entry button for the Explore page.
    song_button = button()
    song_button.margin(5, 5, "", 5)
    song_button.theme = "#1A1A1A"
    song_button.height = 20
    song_button.onClick = on_click_handler
    parent.add(song_button)

    song_picture = costume("music//" + song_id, 4)
    song_picture.margin("", "","", 10)
    song_picture.size(1)
    song_button.add(song_picture)

    title_label = label(song_title, 8)
    title_label.margin("","","","")
    title_label.align = 0.5
    song_button.add(title_label)

    interpreter_label = label(interpreter, 8)
    interpreter_label.margin("",10,"","")
    interpreter_label.align = 1
    song_button.add(interpreter_label)
}

def add_song_preview(parent, song_id, on_click_handler) {
    // Creates a song preview element for the Home page.
    playbutton = container()
    playbutton.margin("","","",15)
    playbutton.size(70,70)
    playbutton.onClick = on_click_handler
    parent.add(playbutton)

    song_preview = costume("music//" + song_id, 10)
    song_preview.margin("","","", 35)
    song_preview.size(2)
    playbutton.add(song_preview)
}

def create_lyrics_line(parent, text, on_click_handler) {
    // Creates a single line of lyrics
    line_container = container()
    line_container.margin(20, 5, "", 5)
    line_container.height = 10
    parent.add(line_container)

    word_label = label(text, 12)
    word_label.onClick = on_click_handler
    line_container.add(word_label)
    return word_label
}

def add_playlist_preview(parent, costume_name, on_click_handler) {
    // Creates a playlist preview element for the Playlists page.
    playlist_container = container()
    playlist_container.margin("","","",15)
    playlist_container.size(70,70)
    playlist_container.onClick = on_click_handler
    parent.add(playlist_container)

    playlist_costume = costume(costume_name, 10)
    playlist_costume.size(2)
    playlist_container.add(playlist_costume)
}

// ---------------------------------------------------
// --              PLAYLIST FUNCTIONS               --
// ---------------------------------------------------

def open_pop_playlist() {
    pop_window = window(300, 250)
    pop_window.center()
    
    scroll = vScrollContainer()
    scroll.margin(5)
    pop_window.add(scroll)
    
    create_song_entry(scroll, "diamond-heart", "Diamond Heart", "Alan Walker", "diamond_heart")
    create_song_entry(scroll, "never-gonna-give-you-up", "Never Gonna Give You Up", "Rick Astley", "never_gonna_give_you_up")
    create_song_entry(scroll, "hall-of-fame", "Hall of Fame", "The Script", "hall_of_fame")
    create_song_entry(scroll, "viva-la-vida", "Viva la Vida", "Coldplay", "viva_la_vida")
    create_song_entry(scroll, "above-the-skies", "Above the Skies", "RedOS-Paulottix", "above_the_skies")
}

def open_rock_playlist() {
    rock_window = window(300, 250)
    rock_window.center()

    scroll = vScrollContainer()
    scroll.margin(5)
    rock_window.add(scroll)

    create_song_entry(scroll, "lost", "Lost", "Linkin Park", "lost")
    create_song_entry(scroll, "somewhere-i-belong", "Somewhere I Belong", "Linkin Park", "somewhere_i_belong")
    create_song_entry(scroll, "nothing-else-matters", "Nothing Else Matters", "Metallica", "nothing_else_matters")
    create_song_entry(scroll, "hotel-california", "Hotel California", "Eagles", "hotel_california")
    create_song_entry(scroll, "everything-ends", "Everything Ends", "Architects", "everything_ends")
}

def open_rick_playlist() {
    rick_window = window(300, 250)
    rick_window.center()

    scroll = vScrollContainer()
    scroll.margin(5)
    rick_window.add(scroll)

    create_song_entry(scroll, "never-gonna-give-you-up", "Never Gonna Give You Up", "Rick Astley", "never_gonna_give_you_up")
    create_song_entry(scroll, "hotel-california", "Hotel California", "Eagles", "hotel_california")
    create_song_entry(scroll, "viva-la-vida", "Viva la Vida", "Coldplay", "viva_la_vida")
    create_song_entry(scroll, "hall-of-fame", "Hall of Fame", "The Script", "hall_of_fame")
    create_song_entry(scroll, "that-bass", "That Bass Will Grow On You", "RedOS-Paulottix", "that_bass")
}

def add_playlist_clicked() {
    global num_added_playlists += 1
    if (num_added_playlists == 1) {
        global playlist_row_2 = hScrollContainer()
        playlist_row_2.margin(15,10,"",10)
        playlist_row_2.height = 75
        playlists_vbox.add(playlist_row_2)
        add_playlist_preview(playlist_row_2, "music//lost", "open_generic_playlist_1")
    } elif (num_added_playlists == 2) {
        add_playlist_preview(playlist_row_2, "music//lost", "open_generic_playlist_2")
    } elif (num_added_playlists == 3) {
        add_playlist_preview(playlist_row_2, "music//lost", "open_generic_playlist_3")
    } elif (num_added_playlists == 4) {
        global playlist_row_3 = hScrollContainer()
        playlist_row_3.margin(15,10,"",10)
        playlist_row_3.height = 75
        playlists_vbox.add(playlist_row_3)
        add_playlist_preview(playlist_row_3, "music//lost", "open_generic_playlist_4")
    } elif (num_added_playlists == 5) {
        add_playlist_preview(playlist_row_3, "music//lost", "open_generic_playlist_5")
    } elif (num_added_playlists == 6) {
        add_playlist_preview(playlist_row_3, "music//lost", "open_generic_playlist_6")
    }
}

def open_generic_playlist_content() {
    new_playlist_window = window(300, 250)
    new_playlist_window.center()

    scroll = vScrollContainer()
    scroll.margin(5)
    new_playlist_window.add(scroll)

    create_song_entry(scroll, "legends", "Legends", "RedOS-Paulottix", "legends")
    create_song_entry(scroll, "no", "No Return", "RedOS-Paulottix", "no")
    create_song_entry(scroll, "gladius", "Gladius Superabit", "Paulottix,SunoAi,Citrus", "gladius")
    create_song_entry(scroll, "mountains", "Where the Mountain Ends", "RedOS-Paulottix", "mountain")
    create_song_entry(scroll, "that-bass", "That Bass Will Grow On You", "RedOS-Paulottix", "that_bass")
}

def open_generic_playlist_1() { open_generic_playlist_content() }
def open_generic_playlist_2() { open_generic_playlist_content() }
def open_generic_playlist_3() { open_generic_playlist_content() }
def open_generic_playlist_4() { open_generic_playlist_content() }
def open_generic_playlist_5() { open_generic_playlist_content() }
def open_generic_playlist_6() { open_generic_playlist_content() }

// ---------------------------------------------------
// --              ORIGINAL FUNCTIONS               --
// ---------------------------------------------------

def start_music() {
    os.music_toggle()
}

def skip_f_music() {
    os.music_skip()
}

def skip_b_music() {
    os.music_skip_back()
}

def format_time(seconds) {
    minutes = floor(seconds / 60)
    secs = floor(seconds % 60)
    if (secs < 10) {
        return minutes + ":0" + secs
    }
    return minutes + ":" + secs
}

def new_start() {
    os.music_start("lost")
}

// Song click handlers (unchanged because language requires static function names for callbacks)
def viva_la_vida(){ os.music_start("viva-la-vida") }
def hotel_california(){ os.music_start("hotel-california") }
def lost(){ os.music_start("lost") }
def nothing_else_matters(){ os.music_start("nothing-else-matters") }
def somewhere_i_belong(){ os.music_start("somewhere-i-belong") }
def everything_ends(){ os.music_start("everything-ends") }
def hall_of_fame(){ os.music_start("hall-of-fame") }
def call_of_the_wild(){ os.music_start("call-of-the-wild") }
def diamond_heart(){ os.music_start("diamond-heart") }
def never_gonna_give_you_up(){ os.music_start("never-gonna-give-you-up") }
def above_the_skies(){ os.music_start("above-the-skies") }
def legends(){ os.music_start("legends") }
def gladius(){ os.music_start("gladius") }
def mountain(){ os.music_start("mountains") }
def mountain_ends(){ os.music_start("where_the_mountain_ends_progressive_house_version") }
def no(){ os.music_start("no") }
def gladius_superabit(){ os.music_start("gladius-superabit-v2") }
def that_bass(){ os.music_start("that-bass") }

// Lyrics click handlers
def lyrics1(){ os.music_set_progress(os.lyrics_time1)
 os.music_play() }
def lyrics2(){ os.music_set_progress(os.lyrics_time2)
 os.music_play() }
def lyrics3(){ os.music_set_progress(os.lyrics_time3)
 os.music_play() }
def lyrics4(){ os.music_set_progress(os.lyrics_time4)
 os.music_play() }
def lyrics5(){ os.music_set_progress(os.lyrics_time5)
 os.music_play() }
