def init() {
    global num_added_playlists = 0
    global window = window(400, 250)
    global all_songs_data
    all_songs_data = "Viva la Vida|Coldplay,Another Brick in the Wall|Pink Floyd,Hotel California|Eagles,Stairway to Heaven|Led Zeppelin,Bohemian Rhapsody|Queen,Smells Like Teen Spirit|Nirvana,Sweet Child O' Mine|Guns N' Roses"
    window.center()
    window.mode = "no resize"

    tabs = tabs()
    tabs.fill()
    tabs.tab = 1
    window.add(tabs)
    
    all_songs_data = "Viva la Vida|Coldplay,Another Brick in the Wall|Pink Floyd,Hotel California|Eagles,Stairway to Heaven|Led Zeppelin,Bohemian Rhapsody|Queen,Smells Like Teen Spirit|Nirvana,Sweet Child O' Mine|Guns N' Roses"

    // --- Playlist status variables ---
    global pop_playlist_status = "000000000000000000"
    global rock_playlist_status = "000000000000000000"
    global rick_playlist_status = "000000000000000000"
    global generic_playlist_status_1 = "000000000000000000"
    global generic_playlist_status_2 = "000000000000000000"
    global generic_playlist_status_3 = "000000000000000000"
    global generic_playlist_status_4 = "000000000000000000"
    global generic_playlist_status_5 = "000000000000000000"
    global generic_playlist_status_6 = "000000000000000000"

    global current_playlist_window = 0
    global current_playlist_status_var = ""
    global switch_0 = 0
    global switch_1 = 0
    global switch_2 = 0
    global switch_3 = 0
    global switch_4 = 0
    global switch_5 = 0
    global switch_6 = 0
    global switch_7 = 0
    global switch_8 = 0
    global switch_9 = 0
    global switch_10 = 0
    global switch_11 = 0
    global switch_12 = 0
    global switch_13 = 0
    global switch_14 = 0
    global switch_15 = 0
    global switch_16 = 0
    global switch_17 = 0

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
    music_player.theme = 0.1
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
    music_player2.theme = 0.1
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
    music_player3.theme = 0.1
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
    music_player4.theme = 0.1
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
    explore_scroll.margin(20, 5, 40, 5)
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
    lyrics_container.margin(20, 5, 50, 5)
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

    add_playlist_preview(playlist_row_1, "music//lost", "pop")
    add_playlist_preview(playlist_row_1, "music//no", "rock")
    add_playlist_preview(playlist_row_1, "music//never-gonna-give-you-up", "rick")
}

def frame() {
    global current_playlist_status_var
    global switch_0
    global switch_1
    global switch_2
    global switch_3
    global switch_4
    global switch_5
    global switch_6
    global switch_7
    global switch_8
    global switch_9
    global switch_10
    global switch_11
    global switch_12
    global switch_13
    global switch_14
    global switch_15
    global switch_16
    global switch_17
    
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

    // Update playlist status string if a playlist window is open
    if (current_playlist_status_var != "") {
        new_status = ""
        if (switch_0 != 0) { new_status = new_status + str(switch_0.state) } else { new_status = new_status + "0" }
        if (switch_1 != 0) { new_status = new_status + str(switch_1.state) } else { new_status = new_status + "0" }
        if (switch_2 != 0) { new_status = new_status + str(switch_2.state) } else { new_status = new_status + "0" }
        if (switch_3 != 0) { new_status = new_status + str(switch_3.state) } else { new_status = new_status + "0" }
        if (switch_4 != 0) { new_status = new_status + str(switch_4.state) } else { new_status = new_status + "0" }
        if (switch_5 != 0) { new_status = new_status + str(switch_5.state) } else { new_status = new_status + "0" }
        if (switch_6 != 0) { new_status = new_status + str(switch_6.state) } else { new_status = new_status + "0" }
        if (switch_7 != 0) { new_status = new_status + str(switch_7.state) } else { new_status = new_status + "0" }
        if (switch_8 != 0) { new_status = new_status + str(switch_8.state) } else { new_status = new_status + "0" }
        if (switch_9 != 0) { new_status = new_status + str(switch_9.state) } else { new_status = new_status + "0" }
        if (switch_10 != 0) { new_status = new_status + str(switch_10.state) } else { new_status = new_status + "0" }
        if (switch_11 != 0) { new_status = new_status + str(switch_11.state) } else { new_status = new_status + "0" }
        if (switch_12 != 0) { new_status = new_status + str(switch_12.state) } else { new_status = new_status + "0" }
        if (switch_13 != 0) { new_status = new_status + str(switch_13.state) } else { new_status = new_status + "0" }
        if (switch_14 != 0) { new_status = new_status + str(switch_14.state) } else { new_status = new_status + "0" }
        if (switch_15 != 0) { new_status = new_status + str(switch_15.state) } else { new_status = new_status + "0" }
        if (switch_16 != 0) { new_status = new_status + str(switch_16.state) } else { new_status = new_status + "0" }
        if (switch_17 != 0) { new_status = new_status + str(switch_17.state) } else { new_status = new_status + "0" }
        set_playlist_status(current_playlist_status_var, new_status)
    }
}

// ---------------------------------------------------
// --              REUSABLE HELPER FUNCTIONS        --
// ---------------------------------------------------

def create_song_entry(parent, song_id, song_title, interpreter, on_click_handler) {
    // Creates a single song entry button for the Explore page.
    song_button = button()
    song_button.margin(5, 5, "", 5)
    song_button.theme = 0.1
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
    line_container.margin(10, 5, "", 5)
    line_container.height = "shrink"
    parent.add(line_container)

    word_label = label(text, 12, 0, 1)
    word_label.onClick = on_click_handler
    line_container.add(word_label)
    return word_label
}

def add_playlist_preview(parent, costume_name, playlist_name) {
    // Creates a playlist preview element for the Playlists page.
    playlist_container = container()
    playlist_container.margin("","","",15)
    playlist_container.size(70,70)
    playlist_container.onClick = "open_playlist_details_" + playlist_name
    parent.add(playlist_container)

    playlist_costume = costume(costume_name, 10)
    playlist_costume.size(2)
    playlist_container.add(playlist_costume)
}

// ---------------------------------------------------
// --              PLAYLIST FUNCTIONS               --
// ---------------------------------------------------

def open_playlist_details_pop() {
    open_playlist_details("Pop Playlist", "music//lost", "pop_playlist_status")
}
def open_playlist_details_rock() {
    open_playlist_details("Rock Playlist", "music//no", "rock_playlist_status")
}
def open_playlist_details_rick() {
    open_playlist_details("Rick Playlist", "music//never-gonna-give-you-up", "rick_playlist_status")
}
def open_playlist_details_generic_1() {
    open_playlist_details("Generic Playlist 1", "music//lost", "generic_playlist_status_1")
}
def open_playlist_details_generic_2() {
    open_playlist_details("Generic Playlist 2", "music//lost", "generic_playlist_status_2")
}
def open_playlist_details_generic_3() {
    open_playlist_details("Generic Playlist 3", "music//lost", "generic_playlist_status_3")
}
def open_playlist_details_generic_4() {
    open_playlist_details("Generic Playlist 4", "music//lost", "generic_playlist_status_4")
}
def open_playlist_details_generic_5() {
    open_playlist_details("Generic Playlist 5", "music//lost", "generic_playlist_status_5")
}
def open_playlist_details_generic_6() {
    open_playlist_details("Generic Playlist 6", "music//lost", "generic_playlist_status_6")
}

def add_playlist_clicked() {
    global num_added_playlists
    global playlists_vbox
    num_added_playlists += 1

    if (num_added_playlists == 1) {
        global playlist_row_2
        playlist_row_2 = hScrollContainer()
        playlist_row_2.margin(15,10,"",10)
        playlist_row_2.height = 75
        playlists_vbox.add(playlist_row_2)
        add_playlist_preview(playlist_row_2, "music//lost", "generic_1")
    } elif (num_added_playlists == 2) {
        global playlist_row_2
        add_playlist_preview(playlist_row_2, "music//lost", "generic_2")
    } elif (num_added_playlists == 3) {
        global playlist_row_2
        add_playlist_preview(playlist_row_2, "music//lost", "generic_3")
    } elif (num_added_playlists == 4) {
        global playlist_row_3
        playlist_row_3 = hScrollContainer()
        playlist_row_3.margin(15,10,"",10)
        playlist_row_3.height = 75
        playlists_vbox.add(playlist_row_3)
        add_playlist_preview(playlist_row_3, "music//lost", "generic_4")
    } elif (num_added_playlists == 5) {
        global playlist_row_3
        add_playlist_preview(playlist_row_3, "music//lost", "generic_5")
    } elif (num_added_playlists == 6) {
        global playlist_row_3
        add_playlist_preview(playlist_row_3, "music//lost", "generic_6")
    }
}

def close_playlist_details_window() {
    global current_playlist_window
    global current_playlist_status_var
    global switch_0
    global switch_1
    global switch_2
    global switch_3
    global switch_4
    global switch_5
    global switch_6
    global switch_7
    global switch_8
    global switch_9
    global switch_10
    global switch_11
    global switch_12
    global switch_13
    global switch_14
    global switch_15
    global switch_16
    global switch_17
    
    if (current_playlist_window != 0) {
        current_playlist_window.close()
    }

    current_playlist_window = 0
    current_playlist_status_var = ""
    switch_0 = 0
    switch_1 = 0
    switch_2 = 0
    switch_3 = 0
    switch_4 = 0
    switch_5 = 0
    switch_6 = 0
    switch_7 = 0
    switch_8 = 0
    switch_9 = 0
    switch_10 = 0
    switch_11 = 0
    switch_12 = 0
    switch_13 = 0
    switch_14 = 0
    switch_15 = 0
    switch_16 = 0
    switch_17 = 0
}

def open_playlist_details(playlist_name, cover_image, status_var_name) {
    global current_playlist_window
    global current_playlist_status_var
    global switch_0
    global switch_1
    global switch_2
    global switch_3
    global switch_4
    global switch_5
    global switch_6
    global switch_7
    global switch_8
    global switch_9
    global switch_10
    global switch_11
    global switch_12
    global switch_13
    global switch_14
    global switch_15
    global switch_16
    global switch_17

    os.print("music_app: open_playlist_details called for " + playlist_name)
    current_playlist_window = window(260, 200)
    current_playlist_window.mode = "no resize"
    current_playlist_window.center()
    current_playlist_status_var = status_var_name

    title_label = label(playlist_name)
    title_label.margin(10, "", "", 0)
    title_label.align = 0.5
    current_playlist_window.add(title_label)

    songs_container = vScrollContainer()
    songs_container.margin(55, 10, 50, 10)
    songs_container.height = 120
    current_playlist_window.add(songs_container)
    
    status_str = get_playlist_status(status_var_name)
    
    switch_0 = add_song_with_switch_entry(songs_container, 0, "viva-la-vida", "viva la vida", "Coldplay", status_str)
    switch_1 = add_song_with_switch_entry(songs_container, 1, "hotel-california", "hotel california", "Eagles", status_str)
    switch_2 = add_song_with_switch_entry(songs_container, 2, "lost", "lost", "Linkin Park", status_str)
    switch_3 = add_song_with_switch_entry(songs_container, 3, "nothing-else-matters", "nothing else matters", "Metallica", status_str)
    switch_4 = add_song_with_switch_entry(songs_container, 4, "somewhere-i-belong", "somewhere i belong", "Linkin Park", status_str)
    switch_5 = add_song_with_switch_entry(songs_container, 5, "everything-ends", "everything ends", "Architects", status_str)
    switch_6 = add_song_with_switch_entry(songs_container, 6, "hall-of-fame", "hall of fame", "The Script", status_str)
    switch_7 = add_song_with_switch_entry(songs_container, 7, "call-of-the-wild", "call of the wild", "Powerwulf", status_str)
    switch_8 = add_song_with_switch_entry(songs_container, 8, "diamond-heart", "diamond heart", "Alan Walker", status_str)
    switch_9 = add_song_with_switch_entry(songs_container, 9, "never-gonna-give-you-up", "never gonna give you up", "Rick Astley", status_str)
    switch_10 = add_song_with_switch_entry(songs_container, 10, "above-the-skies", "Above the skies", "RedOS-Paulottix", status_str)
    switch_11 = add_song_with_switch_entry(songs_container, 11, "legends", "legends", "RedOS-Paulottix", status_str)
    switch_12 = add_song_with_switch_entry(songs_container, 12, "gladius", "Gladius Superabit", "Paulottix,SunoAi,Citrus", status_str)
    switch_13 = add_song_with_switch_entry(songs_container, 13, "mountains", "where the mountain ends", "RedOS-Paulottix", status_str)
    switch_14 = add_song_with_switch_entry(songs_container, 14, "where_the_mountain_ends_progressive_house_version", "Where the m. ends ph", "RedOS-Paulottix", status_str)
    switch_15 = add_song_with_switch_entry(songs_container, 15, "no", "No Return", "RedOS-Paulottix", status_str)
    switch_16 = add_song_with_switch_entry(songs_container, 16, "that-bass", "That Bass will grow on you ig", "RedOS-Paulottix", status_str)
    switch_17 = add_song_with_switch_entry(songs_container, 17, "gladius-superabit-v2", "Gladius Superabit v2", "RedOS-Paulottix", status_str)

    close_button = button("Close", "close_playlist_details_window")
    close_button.margin(195, "", 10, "")
    close_button.align = 0.5
    current_playlist_window.add(close_button)

    os.print("music_app: finished adding all songs, window should be visible now")
}

def add_song_with_switch_entry(parent, idx, song_id, song_title, interpreter, status_str) {
    song_button = button()
    song_button.margin(5, 5, "", 5)
    song_button.theme = 0.1
    song_button.height = 20
    parent.add(song_button)

    song_picture = costume("music//" + song_id, 4)
    song_picture.margin("", "","", 10)
    song_picture.size(1)
    song_button.add(song_picture)

    // Concatenate with extra spaces for separation
    name_interpreter = song_title + "        " + interpreter
    name_interpreter_label = label(name_interpreter, 8)
    name_interpreter_label.margin("", "", "", 0)
    name_interpreter_label.align = 0.3
    song_button.add(name_interpreter_label)

    song_switch = switch()
    song_switch.margin(5, "", "", 220)
    if (os.get_char(status_str, idx) == "1") {
        song_switch.state = 1
    } else {
        song_switch.state = 0
    }
    song_button.add(song_switch)
    return song_switch
}

def get_playlist_status(var_name) {
    global pop_playlist_status
    global rock_playlist_status
    global rick_playlist_status
    global generic_playlist_status_1
    global generic_playlist_status_2
    global generic_playlist_status_3
    global generic_playlist_status_4
    global generic_playlist_status_5
    global generic_playlist_status_6

    if (var_name == "pop_playlist_status") { return pop_playlist_status }
    if (var_name == "rock_playlist_status") { return rock_playlist_status }
    if (var_name == "rick_playlist_status") { return rick_playlist_status }
    if (var_name == "generic_playlist_status_1") { return generic_playlist_status_1 }
    if (var_name == "generic_playlist_status_2") { return generic_playlist_status_2 }
    if (var_name == "generic_playlist_status_3") { return generic_playlist_status_3 }
    if (var_name == "generic_playlist_status_4") { return generic_playlist_status_4 }
    if (var_name == "generic_playlist_status_5") { return generic_playlist_status_5 }
    if (var_name == "generic_playlist_status_6") { return generic_playlist_status_6 }
    return "000000000000000000"
}

def set_playlist_status(var_name, value) {
    global pop_playlist_status
    global rock_playlist_status
    global rick_playlist_status
    global generic_playlist_status_1
    global generic_playlist_status_2
    global generic_playlist_status_3
    global generic_playlist_status_4
    global generic_playlist_status_5
    global generic_playlist_status_6

    if (var_name == "pop_playlist_status") { pop_playlist_status = value }
    if (var_name == "rock_playlist_status") { rock_playlist_status = value }
    if (var_name == "rick_playlist_status") { rick_playlist_status = value }
    if (var_name == "generic_playlist_status_1") { generic_playlist_status_1 = value }
    if (var_name == "generic_playlist_status_2") { generic_playlist_status_2 = value }
    if (var_name == "generic_playlist_status_3") { generic_playlist_status_3 = value }
    if (var_name == "generic_playlist_status_4") { generic_playlist_status_4 = value }
    if (var_name == "generic_playlist_status_5") { generic_playlist_status_5 = value }
    if (var_name == "generic_playlist_status_6") { generic_playlist_status_6 = value }
}

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

def add_song_to_playlist_view(parent, song_title, y_offset) {
    song_label = label(song_title)
    song_label.margin(y_offset, "", "", 20)
    parent.add(song_label)
}

def add_song_with_switch(parent, song_title) {
    os.print("music_app: adding switch for " + song_title)
    song_entry_container = container()
    song_entry_container.height = 30
    parent.add(song_entry_container)

    song_label = label(song_title)
    song_label.margin(5, "", "", 10)
    song_entry_container.add(song_label)

    song_switch = switch()
    song_switch.margin(5, 10, "", "")
    song_entry_container.add(song_switch)
}
