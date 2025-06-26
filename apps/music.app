def init() {
    
    global window = window(400, 250)
    global all_songs_data
    all_songs_data = "viva la vida|Coldplay,hotel california|Eagles,lost|Linkin Park,nothing else matters|Metallica,somewhere i belong|Linkin Park,everything ends|Architects,hall of fame|The Script,call of the wild|Powerwulf,diamond heart|Alan Walker,never gonna give you up|Rick Astley,Above the skies|RedOS-Paulottix,legends|RedOS-Paulottix,Gladius Superabit|Paulottix,SunoAi,Citrus,where the mountain ends|RedOS-Paulottix,Where the m. ends ph|RedOS-Paulottix,No Return|RedOS-Paulottix,That Bass will grow on you ig|RedOS-Paulottix,Gladius Superabit v2|RedOS-Paulottix"
    window.center()
    window.mode = "no resize"

    global current_queue_index
    current_queue_index = 0
    global playlist_queue = list("viva-la-vida", "hotel-california", "lost", "nothing-else-matters", "somewhere-i-belong", "everything-ends", "hall-of-fame", "call-of-the-wild", "diamond-heart", "never-gonna-give-you-up", "above-the-skies", "legends", "gladius", "mountains", "where_the_mountain_ends_progressive_house_version", "no", "that-bass", "gladius-superabit-v2")
    global num_added_playlists = 0

    tabs = tabs()
    tabs.fill()
    tabs.tab = 1
    window.add(tabs)
    
    global tab1
    global tab2
    global tab3
    global tab4
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
    play_symbol.onClick = "start_music()"
    tab1.add(play_symbol)

    global skip_back = costume("music//skip_back", 5)
    skip_back.margin(225, "", 5, 230)
    skip_back.size(15)
    skip_back.onClick = "skip_b_music()"
    tab1.add(skip_back)

    global skip_forward = costume("music//skip_forward", 5)
    skip_forward.margin(225, "", 5, 270)
    skip_forward.size(15)
    skip_forward.onClick = "skip_f_music()"
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
    play_symbol2.onClick = "start_music()"
    tab2.add(play_symbol2)

    global skip_back2 = costume("music//skip_back", 5)
    skip_back2.margin(225, "", 5, 235)
    skip_back2.size(15)
    skip_back2.onClick = "skip_b_music()"
    tab2.add(skip_back2)

    global skip_forward2 = costume("music//skip_forward", 5)
    skip_forward2.margin(225, "", 5, 275)
    skip_forward2.size(15)
    skip_forward2.onClick = "skip_f_music()"
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
    play_symbol3.onClick = "start_music()"
    tab3.add(play_symbol3)

    global skip_back3 = costume("music//skip_back", 5)
    skip_back3.margin(225, "", 5, 230)
    skip_back3.size(15)
    skip_back3.onClick = "skip_b_music()"
    tab3.add(skip_back3)

    global skip_forward3 = costume("music//skip_forward", 5)
    skip_forward3.margin(225, "", 5, 270)
    skip_forward3.size(15)
    skip_forward3.onClick = "skip_f_music()"
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
    play_symbol4.onClick = "start_music()"
    tab4.add(play_symbol4)

    global skip_back4 = costume("music//skip_back", 5)
    skip_back4.margin(225, "", 5, 230)
    skip_back4.size(15)
    skip_back4.onClick = "skip_b_music()"
    tab4.add(skip_back4)

    global skip_forward4 = costume("music//skip_forward", 5)
    skip_forward4.margin(225, "", 5, 270)
    skip_forward4.size(15)
    skip_forward4.onClick = "skip_f_music()"
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

    global current_playlist_offset = 0

    // At the top, after other globals:
    global pop_playlist_list = list()
    global rock_playlist_list = list()
    global rick_playlist_list = list()
    global generic_playlist_list_1 = list()
    global generic_playlist_list_2 = list()
    global generic_playlist_list_3 = list()
    global generic_playlist_list_4 = list()
    global generic_playlist_list_5 = list()
    global generic_playlist_list_6 = list()

    global last_mps_skip_status = os.mps_skip_status
}

def setup_home_tab(tab) {
    home_vbox = vScrollContainer()
    home_vbox.margin(60, 5, 60, 5)
    tab.add(home_vbox)

    news_container = container()
    news_container.margin(0,10,"", 10)
    news_container.height = 75
    news_container.onClick = "gladius()"
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
    
    add_song_preview(song_shown_first, "diamond-heart", "diamond_heart()")
    add_song_preview(song_shown_first, "lost", "lost()")
    add_song_preview(song_shown_first, "never-gonna-give-you-up", "never_gonna_give_you_up()")

    song_shown_first2 = hScrollContainer()
    song_shown_first2.margin(5,10,"", 10)
    song_shown_first2.height = 75
    home_vbox.add(song_shown_first2)

    add_song_preview(song_shown_first2, "hall-of-fame", "hall_of_fame()")
    add_song_preview(song_shown_first2, "hotel-california", "hotel_california()")
    add_song_preview(song_shown_first2, "call-of-the-wild", "call_of_the_wild()")

    home_vbox.scrollUp()
}

def setup_explore_tab(tab) {
    explore_scroll = vScrollContainer()
    explore_scroll.margin(20, 5, 40, 5)
    tab.add(explore_scroll)

    // Add all the songs to the explore list
    create_song_entry(explore_scroll, "viva-la-vida", "viva la vida", "Coldplay", "explore_click_song(\"viva-la-vida\")")
    create_song_entry(explore_scroll, "hotel-california", "hotel california", "Eagles", "explore_click_song(\"hotel-california\")")
    create_song_entry(explore_scroll, "lost", "lost", "Linkin Park", "explore_click_song(\"lost\")")
    create_song_entry(explore_scroll, "nothing-else-matters", "nothing else matters", "Metallica", "explore_click_song(\"nothing-else-matters\")")
    create_song_entry(explore_scroll, "somewhere-i-belong", "somewhere i belong", "Linkin Park", "explore_click_song(\"somewhere-i-belong\")")
    create_song_entry(explore_scroll, "everything-ends", "everything ends", "Architects", "explore_click_song(\"everything-ends\")")
    create_song_entry(explore_scroll, "hall-of-fame", "hall of fame", "The Script", "explore_click_song(\"hall-of-fame\")")
    create_song_entry(explore_scroll, "call-of-the-wild", "call of the wild", "Powerwulf", "explore_click_song(\"call-of-the-wild\")")
    create_song_entry(explore_scroll, "diamond-heart", "diamond heart", "Alan Walker", "explore_click_song(\"diamond-heart\")")
    create_song_entry(explore_scroll, "never-gonna-give-you-up", "never gonna give you up", "Rick Astley", "explore_click_song(\"never-gonna-give-you-up\")")
    create_song_entry(explore_scroll, "above-the-skies", "Above the skies", "RedOS-Paulottix", "explore_click_song(\"above-the-skies\")")
    create_song_entry(explore_scroll, "legends", "legends", "RedOS-Paulottix", "explore_click_song(\"legends\")")
    create_song_entry(explore_scroll, "gladius", "Gladius Superabit", "Paulottix,SunoAi,Citrus", "explore_click_song(\"gladius\")")
    create_song_entry(explore_scroll, "mountains", "where the mountain ends", "RedOS-Paulottix", "explore_click_song(\"mountains\")")
    create_song_entry(explore_scroll, "where_the_mountain_ends_progressive_house_version", "Where the m. ends ph", "RedOS-Paulottix", "explore_click_song(\"where_the_mountain_ends_progressive_house_version\")")
    create_song_entry(explore_scroll, "no", "No Return", "RedOS-Paulottix", "explore_click_song(\"no\")")
    create_song_entry(explore_scroll, "that-bass", "That Bass will grow on you ig", "RedOS-Paulottix", "explore_click_song(\"that-bass\")")
    create_song_entry(explore_scroll, "gladius-superabit-v2", "Gladius Superabit v2", "RedOS-Paulottix", "explore_click_song(\"gladius-superabit-v2\")")
}

def setup_lyrics_tab(tab) {
    lyrics_container = vScrollContainer()
    lyrics_container.margin(20, 5, 50, 5)
    tab.add(lyrics_container)
    
    os.music_get_line()

    global lyrics_word1 = create_lyrics_line(lyrics_container, " ", "lyrics1()")
    global lyrics_word2 = create_lyrics_line(lyrics_container, " ", "lyrics2()")
    global lyrics_word3 = create_lyrics_line(lyrics_container, "Please start a song", "lyrics3()")
    global lyrics_word4 = create_lyrics_line(lyrics_container, " ", "lyrics4()")
    global lyrics_word5 = create_lyrics_line(lyrics_container, " ", "lyrics5()")
    
    lyrics_container.scrollUp()
}

def setup_playlists_tab(tab) {
    global playlists_vbox = vScrollContainer()
    playlists_vbox.margin(60, 5, 60, 5)
    tab.add(playlists_vbox)

    add_button = button("Add New Playlist", "add_playlist_clicked()")
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
    if (os.mps_skip_status == 0 && last_mps_skip_status == 1) {
        os.music_set_progress(progress)
        os.music_play()
    }
    last_mps_skip_status = os.mps_skip_status

    if (os.music_length - os.music_progress < 5) {
        os.print("music:" + playlist_queue.get(playlist_queue.index(os.music_song_id) + 1))
        os.music_start(playlist_queue.get(playlist_queue.index(os.music_song_id) + 1))
        os.music_set_progress(0) 
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
    title_label.margin("","","",0)
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
    playlist_container.onClick = "open_playlist_details_" + playlist_name + "()"
    parent.add(playlist_container)

    playlist_costume = costume(costume_name, 10)
    playlist_costume.size(2)
    playlist_container.add(playlist_costume)
}

// ---------------------------------------------------
// --              PLAYLIST FUNCTIONS               --
// ---------------------------------------------------

def open_playlist_details_pop() {
    os.print("Clicked pop playlist!")
    open_playlist_details("Pop Playlist", "music//lost", "pop_playlist_status")
}
def open_playlist_details_rock() {
    os.print("Clicked rock playlist!")
    open_playlist_details("Rock Playlist", "music//no", "rock_playlist_status")
}
def open_playlist_details_rick() {
    os.print("Clicked rick playlist!")
    open_playlist_details("Rick Playlist", "music//never-gonna-give-you-up", "rick_playlist_status")
}
def open_playlist_details_generic_1() {
    os.print("Clicked generic_1 playlist!")
    open_playlist_details("Generic Playlist 1", "music//lost", "generic_playlist_status_1")
}
def open_playlist_details_generic_2() {
    os.print("Clicked generic_2 playlist!")
    open_playlist_details("Generic Playlist 2", "music//lost", "generic_playlist_status_2")
}
def open_playlist_details_generic_3() {
    os.print("Clicked generic_3 playlist!")
    open_playlist_details("Generic Playlist 3", "music//lost", "generic_playlist_status_3")
}
def open_playlist_details_generic_4() {
    os.print("Clicked generic_4 playlist!")
    open_playlist_details("Generic Playlist 4", "music//lost", "generic_playlist_status_4")
}
def open_playlist_details_generic_5() {
    os.print("Clicked generic_5 playlist!")
    open_playlist_details("Generic Playlist 5", "music//lost", "generic_playlist_status_5")
}
def open_playlist_details_generic_6() {
    os.print("Clicked generic_6 playlist!")
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

def open_playlist_details(playlist_name, cover_image, status_var_name) {
    os.print("open_playlist_details: called for " + playlist_name)
    os.print("open_playlist_details: creating window")
    current_playlist_window = window(260, 200)
    current_playlist_window.mode = "no resize"
    current_playlist_window.center()

    os.print("open_playlist_details: adding title label")
    title_label = label(playlist_name)
    title_label.margin(10, "", "", 0)
    title_label.align = 0.5
    current_playlist_window.add(title_label)

    add_playlist_to_queue_button = button("Play Playlist", "add_playlist_to_queue_button_" + status_var_name + "()")
    add_playlist_to_queue_button.margin("","",0,"")
    add_playlist_to_queue_button.theme = "#FF4060"
    current_playlist_window.add(add_playlist_to_queue_button)

    os.print("open_playlist_details: adding songs container")
    songs_container = vScrollContainer()
    songs_container.margin(55, 10, 50, 10)
    songs_container.height = 120
    current_playlist_window.add(songs_container)

    // Determine which playlist list to use
    playlist_list = pop_playlist_list
    current_playlist_offset = 0
    if (status_var_name == "pop_playlist_status") {
        playlist_list = pop_playlist_list
        current_playlist_offset = 0
    } else if (status_var_name == "rock_playlist_status") {
        playlist_list = rock_playlist_list
        current_playlist_offset = 18
    } else if (status_var_name == "rick_playlist_status") {
        playlist_list = rick_playlist_list
        current_playlist_offset = 36
    } else if (status_var_name == "generic_playlist_status_1") {
        playlist_list = generic_playlist_list_1
        current_playlist_offset = 54
    } else if (status_var_name == "generic_playlist_status_2") {
        playlist_list = generic_playlist_list_2
        current_playlist_offset = 72
    } else if (status_var_name == "generic_playlist_status_3") {
        playlist_list = generic_playlist_list_3
        current_playlist_offset = 90
    } else if (status_var_name == "generic_playlist_status_4") {
        playlist_list = generic_playlist_list_4
        current_playlist_offset = 108
    } else if (status_var_name == "generic_playlist_status_5") {
        playlist_list = generic_playlist_list_5
        current_playlist_offset = 126
    } else if (status_var_name == "generic_playlist_status_6") {
        playlist_list = generic_playlist_list_6
        current_playlist_offset = 144
    }

    // Song 0
    song_button_0 = button()
    song_button_0.margin(5, 5, "", 5)
    song_button_0.theme = 0.1
    song_button_0.height = 20
    songs_container.add(song_button_0)
    song_picture_0 = costume("music//viva-la-vida", 4)
    song_picture_0.margin("", "","", 10)
    song_picture_0.size(1)
    song_button_0.add(song_picture_0)
    name_interpreter_label_0 = label("viva la vida        Coldplay", 8)
    name_interpreter_label_0.margin("", "", "", 0)
    name_interpreter_label_0.align = 0.3
    song_button_0.add(name_interpreter_label_0)
    song_switch_0 = switch()
    song_switch_0.margin(5, "", "", 220)
    if (playlist_list.index("viva-la-vida") != -1) {
        song_switch_0.state = 1
    } else {
        song_switch_0.state = 0
    }
    song_switch_0.onClick = "s_0()"
    song_button_0.add(song_switch_0)

    // Song 1
    song_button_1 = button()
    song_button_1.margin(5, 5, "", 5)
    song_button_1.theme = 0.1
    song_button_1.height = 20
    songs_container.add(song_button_1)
    song_picture_1 = costume("music//hotel-california", 4)
    song_picture_1.margin("", "","", 10)
    song_picture_1.size(1)
    song_button_1.add(song_picture_1)
    name_interpreter_label_1 = label("hotel california        Eagles", 8)
    name_interpreter_label_1.margin("", "", "", 0)
    name_interpreter_label_1.align = 0.3
    song_button_1.add(name_interpreter_label_1)
    song_switch_1 = switch()
    song_switch_1.margin(5, "", "", 220)
    if (playlist_list.index("hotel-california") != -1) {
        song_switch_1.state = 1
    } else {
        song_switch_1.state = 0
    }
    song_switch_1.onClick = "s_1()"
    song_button_1.add(song_switch_1)

    // Song 2
    song_button_2 = button()
    song_button_2.margin(5, 5, "", 5)
    song_button_2.theme = 0.1
    song_button_2.height = 20
    songs_container.add(song_button_2)
    song_picture_2 = costume("music//lost", 4)
    song_picture_2.margin("", "","", 10)
    song_picture_2.size(1)
    song_button_2.add(song_picture_2)
    name_interpreter_label_2 = label("lost        Linkin Park", 8)
    name_interpreter_label_2.margin("", "", "", 0)
    name_interpreter_label_2.align = 0.3
    song_button_2.add(name_interpreter_label_2)
    song_switch_2 = switch()
    song_switch_2.margin(5, "", "", 220)
    if (playlist_list.index("lost") != -1) {
        song_switch_2.state = 1
    } else {
        song_switch_2.state = 0
    }
    song_switch_2.onClick = "s_2()"
    song_button_2.add(song_switch_2)

    // Song 3
    song_button_3 = button()
    song_button_3.margin(5, 5, "", 5)
    song_button_3.theme = 0.1
    song_button_3.height = 20
    songs_container.add(song_button_3)
    song_picture_3 = costume("music//nothing-else-matters", 4)
    song_picture_3.margin("", "","", 10)
    song_picture_3.size(1)
    song_button_3.add(song_picture_3)
    name_interpreter_label_3 = label("nothing else matters        Metallica", 8)
    name_interpreter_label_3.margin("", "", "", 0)
    name_interpreter_label_3.align = 0.3
    song_button_3.add(name_interpreter_label_3)
    song_switch_3 = switch()
    song_switch_3.margin(5, "", "", 220)
    if (playlist_list.index("nothing-else-matters") != -1) {
        song_switch_3.state = 1
    } else {
        song_switch_3.state = 0
    }
    song_switch_3.onClick = "s_3()"
    song_button_3.add(song_switch_3)

    // Song 4
    song_button_4 = button()
    song_button_4.margin(5, 5, "", 5)
    song_button_4.theme = 0.1
    song_button_4.height = 20
    songs_container.add(song_button_4)
    song_picture_4 = costume("music//somewhere-i-belong", 4)
    song_picture_4.margin("", "","", 10)
    song_picture_4.size(1)
    song_button_4.add(song_picture_4)
    name_interpreter_label_4 = label("somewhere i belong        Linkin Park", 8)
    name_interpreter_label_4.margin("", "", "", 0)
    name_interpreter_label_4.align = 0.3
    song_button_4.add(name_interpreter_label_4)
    song_switch_4 = switch()
    song_switch_4.margin(5, "", "", 220)
    if (playlist_list.index("somewhere-i-belong") != -1) {
        song_switch_4.state = 1
    } else {
        song_switch_4.state = 0
    }
    song_switch_4.onClick = "s_4()"
    song_button_4.add(song_switch_4)

    // Song 5
    song_button_5 = button()
    song_button_5.margin(5, 5, "", 5)
    song_button_5.theme = 0.1
    song_button_5.height = 20
    songs_container.add(song_button_5)
    song_picture_5 = costume("music//everything-ends", 4)
    song_picture_5.margin("", "","", 10)
    song_picture_5.size(1)
    song_button_5.add(song_picture_5)
    name_interpreter_label_5 = label("everything ends        Architects", 8)
    name_interpreter_label_5.margin("", "", "", 0)
    name_interpreter_label_5.align = 0.3
    song_button_5.add(name_interpreter_label_5)
    song_switch_5 = switch()
    song_switch_5.margin(5, "", "", 220)
    if (playlist_list.index("everything-ends") != -1) {
        song_switch_5.state = 1
    } else {
        song_switch_5.state = 0
    }
    song_switch_5.onClick = "s_5()"
    song_button_5.add(song_switch_5)

    // Song 6
    song_button_6 = button()
    song_button_6.margin(5, 5, "", 5)
    song_button_6.theme = 0.1
    song_button_6.height = 20
    songs_container.add(song_button_6)
    song_picture_6 = costume("music//hall-of-fame", 4)
    song_picture_6.margin("", "","", 10)
    song_picture_6.size(1)
    song_button_6.add(song_picture_6)
    name_interpreter_label_6 = label("hall of fame        The Script", 8)
    name_interpreter_label_6.margin("", "", "", 0)
    name_interpreter_label_6.align = 0.3
    song_button_6.add(name_interpreter_label_6)
    song_switch_6 = switch()
    song_switch_6.margin(5, "", "", 220)
    if (playlist_list.index("hall-of-fame") != -1) {
        song_switch_6.state = 1
    } else {
        song_switch_6.state = 0
    }
    song_switch_6.onClick = "s_6()"
    song_button_6.add(song_switch_6)

    // Song 7
    song_button_7 = button()
    song_button_7.margin(5, 5, "", 5)
    song_button_7.theme = 0.1
    song_button_7.height = 20
    songs_container.add(song_button_7)
    song_picture_7 = costume("music//call-of-the-wild", 4)
    song_picture_7.margin("", "","", 10)
    song_picture_7.size(1)
    song_button_7.add(song_picture_7)
    name_interpreter_label_7 = label("call of the wild        Powerwulf", 8)
    name_interpreter_label_7.margin("", "", "", 0)
    name_interpreter_label_7.align = 0.3
    song_button_7.add(name_interpreter_label_7)
    song_switch_7 = switch()
    song_switch_7.margin(5, "", "", 220)
    if (playlist_list.index("call-of-the-wild") != -1) {
        song_switch_7.state = 1
    } else {
        song_switch_7.state = 0
    }
    song_switch_7.onClick = "s_7()"
    song_button_7.add(song_switch_7)

    // Song 8
    song_button_8 = button()
    song_button_8.margin(5, 5, "", 5)
    song_button_8.theme = 0.1
    song_button_8.height = 20
    songs_container.add(song_button_8)
    song_picture_8 = costume("music//diamond-heart", 4)
    song_picture_8.margin("", "","", 10)
    song_picture_8.size(1)
    song_button_8.add(song_picture_8)
    name_interpreter_label_8 = label("diamond heart        Alan Walker", 8)
    name_interpreter_label_8.margin("", "", "", 0)
    name_interpreter_label_8.align = 0.3
    song_button_8.add(name_interpreter_label_8)
    song_switch_8 = switch()
    song_switch_8.margin(5, "", "", 220)
    if (playlist_list.index("diamond-heart") != -1) {
        song_switch_8.state = 1
    } else {
        song_switch_8.state = 0
    }
    song_switch_8.onClick = "s_8()"
    song_button_8.add(song_switch_8)

    // Song 9
    song_button_9 = button()
    song_button_9.margin(5, 5, "", 5)
    song_button_9.theme = 0.1
    song_button_9.height = 20
    songs_container.add(song_button_9)
    song_picture_9 = costume("music//never-gonna-give-you-up", 4)
    song_picture_9.margin("", "","", 10)
    song_picture_9.size(1)
    song_button_9.add(song_picture_9)
    name_interpreter_label_9 = label("never gonna give you up        Rick Astley", 8)
    name_interpreter_label_9.margin("", "", "", 0)
    name_interpreter_label_9.align = 0.3
    song_button_9.add(name_interpreter_label_9)
    song_switch_9 = switch()
    song_switch_9.margin(5, "", "", 220)
    if (playlist_list.index("never-gonna-give-you-up") != -1) {
        song_switch_9.state = 1
    } else {
        song_switch_9.state = 0
    }
    song_switch_9.onClick = "s_9()"
    song_button_9.add(song_switch_9)

    // Song 10
    song_button_10 = button()
    song_button_10.margin(5, 5, "", 5)
    song_button_10.theme = 0.1
    song_button_10.height = 20
    songs_container.add(song_button_10)
    song_picture_10 = costume("music//above-the-skies", 4)
    song_picture_10.margin("", "","", 10)
    song_picture_10.size(1)
    song_button_10.add(song_picture_10)
    name_interpreter_label_10 = label("Above the skies        RedOS-Paulottix", 8)
    name_interpreter_label_10.margin("", "", "", 0)
    name_interpreter_label_10.align = 0.3
    song_button_10.add(name_interpreter_label_10)
    song_switch_10 = switch()
    song_switch_10.margin(5, "", "", 220)
    if (playlist_list.index("above-the-skies") != -1) {
        song_switch_10.state = 1
    } else {
        song_switch_10.state = 0
    }
    song_switch_10.onClick = "s_10()"
    song_button_10.add(song_switch_10)

    // Song 11
    song_button_11 = button()
    song_button_11.margin(5, 5, "", 5)
    song_button_11.theme = 0.1
    song_button_11.height = 20
    songs_container.add(song_button_11)
    song_picture_11 = costume("music//legends", 4)
    song_picture_11.margin("", "","", 10)
    song_picture_11.size(1)
    song_button_11.add(song_picture_11)
    name_interpreter_label_11 = label("legends        RedOS-Paulottix", 8)
    name_interpreter_label_11.margin("", "", "", 0)
    name_interpreter_label_11.align = 0.3
    song_button_11.add(name_interpreter_label_11)
    song_switch_11 = switch()
    song_switch_11.margin(5, "", "", 220)
    if (playlist_list.index("legends") != -1) {
        song_switch_11.state = 1
    } else {
        song_switch_11.state = 0
    }
    song_switch_11.onClick = "s_11()"
    song_button_11.add(song_switch_11)

    // Song 12
    song_button_12 = button()
    song_button_12.margin(5, 5, "", 5)
    song_button_12.theme = 0.1
    song_button_12.height = 20
    songs_container.add(song_button_12)
    song_picture_12 = costume("music//gladius", 4)
    song_picture_12.margin("", "","", 10)
    song_picture_12.size(1)
    song_button_12.add(song_picture_12)
    name_interpreter_label_12 = label("Gladius Superabit        Paulottix,SunoAi,Citrus", 8)
    name_interpreter_label_12.margin("", "", "", 0)
    name_interpreter_label_12.align = 0.3
    song_button_12.add(name_interpreter_label_12)
    song_switch_12 = switch()
    song_switch_12.margin(5, "", "", 220)
    if (playlist_list.index("gladius") != -1) {
        song_switch_12.state = 1
    } else {
        song_switch_12.state = 0
    }
    song_switch_12.onClick = "s_12()"
    song_button_12.add(song_switch_12)

    // Song 13
    song_button_13 = button()
    song_button_13.margin(5, 5, "", 5)
    song_button_13.theme = 0.1
    song_button_13.height = 20
    songs_container.add(song_button_13)
    song_picture_13 = costume("music//mountains", 4)
    song_picture_13.margin("", "","", 10)
    song_picture_13.size(1)
    song_button_13.add(song_picture_13)
    name_interpreter_label_13 = label("where the mountain ends        RedOS-Paulottix", 8)
    name_interpreter_label_13.margin("", "", "", 0)
    name_interpreter_label_13.align = 0.3
    song_button_13.add(name_interpreter_label_13)
    song_switch_13 = switch()
    song_switch_13.margin(5, "", "", 220)
    if (playlist_list.index("mountains") != -1) {
        song_switch_13.state = 1
    } else {
        song_switch_13.state = 0
    }
    song_switch_13.onClick = "s_13()"
    song_button_13.add(song_switch_13)

    // Song 14
    song_button_14 = button()
    song_button_14.margin(5, 5, "", 5)
    song_button_14.theme = 0.1
    song_button_14.height = 20
    songs_container.add(song_button_14)
    song_picture_14 = costume("music//where_the_mountain_ends_progressive_house_version", 4)
    song_picture_14.margin("", "","", 10)
    song_picture_14.size(1)
    song_button_14.add(song_picture_14)
    name_interpreter_label_14 = label("Where the m. ends ph        RedOS-Paulottix", 8)
    name_interpreter_label_14.margin("", "", "", 0)
    name_interpreter_label_14.align = 0.3
    song_button_14.add(name_interpreter_label_14)
    song_switch_14 = switch()
    song_switch_14.margin(5, "", "", 220)
    if (playlist_list.index("where_the_mountain_ends_progressive_house_version") != -1) {
        song_switch_14.state = 1
    } else {
        song_switch_14.state = 0
    }
    song_switch_14.onClick = "s_14()"
    song_button_14.add(song_switch_14)

    // Song 15
    song_button_15 = button()
    song_button_15.margin(5, 5, "", 5)
    song_button_15.theme = 0.1
    song_button_15.height = 20
    songs_container.add(song_button_15)
    song_picture_15 = costume("music//no", 4)
    song_picture_15.margin("", "","", 10)
    song_picture_15.size(1)
    song_button_15.add(song_picture_15)
    name_interpreter_label_15 = label("No Return        RedOS-Paulottix", 8)
    name_interpreter_label_15.margin("", "", "", 0)
    name_interpreter_label_15.align = 0.3
    song_button_15.add(name_interpreter_label_15)
    song_switch_15 = switch()
    song_switch_15.margin(5, "", "", 220)
    if (playlist_list.index("no") != -1) {
        song_switch_15.state = 1
    } else {
        song_switch_15.state = 0
    }
    song_switch_15.onClick = "s_15()"
    song_button_15.add(song_switch_15)

    // Song 16
    song_button_16 = button()
    song_button_16.margin(5, 5, "", 5)
    song_button_16.theme = 0.1
    song_button_16.height = 20
    songs_container.add(song_button_16)
    song_picture_16 = costume("music//that-bass", 4)
    song_picture_16.margin("", "","", 10)
    song_picture_16.size(1)
    song_button_16.add(song_picture_16)
    name_interpreter_label_16 = label("That Bass will grow on you ig        RedOS-Paulottix", 8)
    name_interpreter_label_16.margin("", "", "", 0)
    name_interpreter_label_16.align = 0.3
    song_button_16.add(name_interpreter_label_16)
    song_switch_16 = switch()
    song_switch_16.margin(5, "", "", 220)
    if (playlist_list.index("that-bass") != -1) {
        song_switch_16.state = 1
    } else {
        song_switch_16.state = 0
    }
    song_switch_16.onClick = "s_16()"
    song_button_16.add(song_switch_16)

    // Song 17
    song_button_17 = button()
    song_button_17.margin(5, 5, "", 5)
    song_button_17.theme = 0.1
    song_button_17.height = 20
    songs_container.add(song_button_17)
    song_picture_17 = costume("music//gladius-superabit-v2", 4)
    song_picture_17.margin("", "","", 10)
    song_picture_17.size(1)
    song_button_17.add(song_picture_17)
    name_interpreter_label_17 = label("Gladius Superabit v2        RedOS-Paulottix", 8)
    name_interpreter_label_17.margin("", "", "", 0)
    name_interpreter_label_17.align = 0.3
    song_button_17.add(name_interpreter_label_17)
    song_switch_17 = switch()
    song_switch_17.margin(5, "", "", 220)
    if (playlist_list.index("gladius-superabit-v2") != -1) {
        song_switch_17.state = 1
    } else {
        song_switch_17.state = 0
    }
    song_switch_17.onClick = "s_17()"
    song_button_17.add(song_switch_17)
}

def start_music() {
    os.music_toggle()
}
def s_0() {
    os.set_switch_state(current_playlist_offset + 0)
    update_playlist_list(current_playlist_offset + 0)
}
def s_1() {
    os.set_switch_state(current_playlist_offset + 1)
    update_playlist_list(current_playlist_offset + 1)
}
def s_2() {
    os.set_switch_state(current_playlist_offset + 2)
    update_playlist_list(current_playlist_offset + 2)
}
def s_3() {
    os.set_switch_state(current_playlist_offset + 3)
    update_playlist_list(current_playlist_offset + 3)
}
def s_4() {
    os.set_switch_state(current_playlist_offset + 4)
    update_playlist_list(current_playlist_offset + 4)
}
def s_5() {
    os.set_switch_state(current_playlist_offset + 5)
    update_playlist_list(current_playlist_offset + 5)
}
def s_6() {
    os.set_switch_state(current_playlist_offset + 6)
    update_playlist_list(current_playlist_offset + 6)
}
def s_7() {
    os.set_switch_state(current_playlist_offset + 7)
    update_playlist_list(current_playlist_offset + 7)
}
def s_8() {
    os.set_switch_state(current_playlist_offset + 8)
    update_playlist_list(current_playlist_offset + 8)
}
def s_9() {
    os.set_switch_state(current_playlist_offset + 9)
    update_playlist_list(current_playlist_offset + 9)
}
def s_10() {
    os.set_switch_state(current_playlist_offset + 10)
    update_playlist_list(current_playlist_offset + 10)
}
def s_11() {
    os.set_switch_state(current_playlist_offset + 11)
    update_playlist_list(current_playlist_offset + 11)
}
def s_12() {
    os.set_switch_state(current_playlist_offset + 12)
    update_playlist_list(current_playlist_offset + 12)
}
def s_13() {
    os.set_switch_state(current_playlist_offset + 13)
    update_playlist_list(current_playlist_offset + 13)
}
def s_14() {
    os.set_switch_state(current_playlist_offset + 14)
    update_playlist_list(current_playlist_offset + 14)
}
def s_15() {
    os.set_switch_state(current_playlist_offset + 15)
    update_playlist_list(current_playlist_offset + 15)
}
def s_16() {
    os.set_switch_state(current_playlist_offset + 16)
    update_playlist_list(current_playlist_offset + 16)
}
def s_17() {
    os.set_switch_state(current_playlist_offset + 17)
    update_playlist_list(current_playlist_offset + 17)
}

def skip_f_music() {
    play_next_in_queue()
}

def skip_b_music() {

    if (playlist_queue.index(os.music_song_id) <= 0) 
    { 
        os.music_start(playlist_queue.get(playlist_queue.length - 1))
    }
    else
    { 
        os.print("music:" + playlist_queue.get(playlist_queue.index(os.music_song_id) - 1))
        os.music_start(playlist_queue.get(playlist_queue.index(os.music_song_id) - 1)) 
    }
    
}

def format_time(seconds) {
    minutes = floor(seconds / 60)
    secs = floor(seconds % 60)
    if (secs < 10) {
        return minutes + ":0" + secs
    }
    return minutes + ":" + secs
}

// Song click handlers (unchanged because language requires static function names for callbacks)
def explore_click_song(song) {
    add_song_to_queue(song)
    if (!os.music_is_playing) {
        os.music_skip()
    }
}

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

// Helper to safely get .state or 0 (no typeof, no &&, no [], no ;, no undefined)
def get_switch_state(sw) {
    if (sw != 0) {
        if (sw != "") {
            if (sw.state != 0) {
                return sw.state
            }
            if (sw.state != "") {
                return sw.state
            }
        }
    }
    return 0
}

def play_next_in_queue() {

    if(playlist_queue.index(os.music_song_id) >= playlist_queue.length - 1)
    { 
        os.music_start(playlist_queue.get(0)) 
    }
    else
    { os.print("music:" + playlist_queue.get(playlist_queue.index(os.music_song_id) + 1))
      os.music_start(playlist_queue.get(playlist_queue.index(os.music_song_id) + 1)) 
    }
}

def get_song_id_by_index(idx) {
    if (idx < 0) { idx = 0 }
    if (idx >= playlist_queue.length) { idx = 0 }
    return playlist_queue.get(idx)
}

def get_index_by_song_id(song_id) {
    idx = playlist_queue.index(song_id)
    if (idx == -1) { return 0 }
    return idx
}

def add_song_to_queue(song_id){
    if (playlist_queue.length == 0) {
        playlist_queue.add(song_id)
    } else {
        playlist_queue.insert(song_id, get_index_by_song_id(os.music_song_id) + 1)
    }
}

def update_playlist_list(idx) {
    // Determine which playlist is open by current_playlist_offset
    global pop_playlist_list
    global rock_playlist_list
    global rick_playlist_list
    global generic_playlist_list_1
    global generic_playlist_list_2
    global generic_playlist_list_3
    global generic_playlist_list_4
    global generic_playlist_list_5
    global generic_playlist_list_6
    song_id = get_song_id_by_index(idx - current_playlist_offset)
    sw_state = os.check_switch_state(idx)
    os.print("[DEBUG] update_playlist_list: idx=" + str(idx) + ", song_id=" + song_id + ", sw_state=" + str(sw_state) + ", current_playlist_offset=" + str(current_playlist_offset))
    if (current_playlist_offset == 0) {
        os.print("[DEBUG] pop_playlist_list before: " + str(pop_playlist_list))
        update_list(pop_playlist_list, song_id, sw_state)
        os.print("[DEBUG] pop_playlist_list after: " + str(pop_playlist_list))
    } else if (current_playlist_offset == 18) {
        os.print("[DEBUG] rock_playlist_list before: " + str(rock_playlist_list))
        update_list(rock_playlist_list, song_id, sw_state)
        os.print("[DEBUG] rock_playlist_list after: " + str(rock_playlist_list))
    } else if (current_playlist_offset == 36) {
        os.print("[DEBUG] rick_playlist_list before: " + str(rick_playlist_list))
        update_list(rick_playlist_list, song_id, sw_state)
        os.print("[DEBUG] rick_playlist_list after: " + str(rick_playlist_list))
    } else if (current_playlist_offset == 54) {
        os.print("[DEBUG] generic_playlist_list_1 before: " + str(generic_playlist_list_1))
        update_list(generic_playlist_list_1, song_id, sw_state)
        os.print("[DEBUG] generic_playlist_list_1 after: " + str(generic_playlist_list_1))
    } else if (current_playlist_offset == 72) {
        os.print("[DEBUG] generic_playlist_list_2 before: " + str(generic_playlist_list_2))
        update_list(generic_playlist_list_2, song_id, sw_state)
        os.print("[DEBUG] generic_playlist_list_2 after: " + str(generic_playlist_list_2))
    } else if (current_playlist_offset == 90) {
        os.print("[DEBUG] generic_playlist_list_3 before: " + str(generic_playlist_list_3))
        update_list(generic_playlist_list_3, song_id, sw_state)
        os.print("[DEBUG] generic_playlist_list_3 after: " + str(generic_playlist_list_3))
    } else if (current_playlist_offset == 108) {
        os.print("[DEBUG] generic_playlist_list_4 before: " + str(generic_playlist_list_4))
        update_list(generic_playlist_list_4, song_id, sw_state)
        os.print("[DEBUG] generic_playlist_list_4 after: " + str(generic_playlist_list_4))
    } else if (current_playlist_offset == 126) {
        os.print("[DEBUG] generic_playlist_list_5 before: " + str(generic_playlist_list_5))
        update_list(generic_playlist_list_5, song_id, sw_state)
        os.print("[DEBUG] generic_playlist_list_5 after: " + str(generic_playlist_list_5))
    } else if (current_playlist_offset == 144) {
        os.print("[DEBUG] generic_playlist_list_6 before: " + str(generic_playlist_list_6))
        update_list(generic_playlist_list_6, song_id, sw_state)
        os.print("[DEBUG] generic_playlist_list_6 after: " + str(generic_playlist_list_6))
    }
}

def update_list(playlist_list, song_id, sw_state) {
    if (sw_state) {
        // Add if not present
        if (playlist_list.index(song_id) == -1) {
            playlist_list.add(song_id)
        }
    } else {
        // Remove if present
        idx = playlist_list.index(song_id)
        if (idx != -1) {
            playlist_list.remove(idx)
        }
    }
}

def add_pop_playlist_to_queue() {
    global playlist_queue
    global current_queue_index
    os.print("[DEBUG] add_pop_playlist_to_queue called. pop_playlist_list.length=" + str(pop_playlist_list.length))
    os.print("[DEBUG] pop_playlist_list: " + str(pop_playlist_list))
    os.print("[DEBUG] playlist_queue before: " + str(playlist_queue))
    while (playlist_queue.length > 0) {
        playlist_queue.remove(0)
    }
    idx = 0
    while (idx < pop_playlist_list.length) {
        song_id = pop_playlist_list.get(idx)
        os.print("[DEBUG] Adding song to queue: " + song_id + " from pop_playlist_list")
        add_song_to_queue(song_id)
        idx += 1
    }
    current_queue_index = 0
    os.print("[DEBUG] playlist_queue after: " + str(playlist_queue))
    if (playlist_queue.length > 0) {
        os.music_start(playlist_queue.get(0))
    } else {
        os.print("[DEBUG] No songs enabled in this playlist!")
    }
}

def add_rock_playlist_to_queue() {
    global playlist_queue
    global current_queue_index
    os.print("[DEBUG] add_rock_playlist_to_queue called. rock_playlist_list.length=" + str(rock_playlist_list.length))
    os.print("[DEBUG] rock_playlist_list: " + str(rock_playlist_list))
    os.print("[DEBUG] playlist_queue before: " + str(playlist_queue))
    while (playlist_queue.length > 0) {
        playlist_queue.remove(0)
    }
    idx = 0
    while (idx < rock_playlist_list.length) {
        song_id = rock_playlist_list.get(idx)
        os.print("[DEBUG] Adding song to queue: " + song_id + " from rock_playlist_list")
        add_song_to_queue(song_id)
        idx += 1
    }
    current_queue_index = 0
    os.print("[DEBUG] playlist_queue after: " + str(playlist_queue))
    if (playlist_queue.length > 0) {
        os.music_start(playlist_queue.get(0))
    } else {
        os.print("[DEBUG] No songs enabled in this playlist!")
    }
}

def add_rick_playlist_to_queue() {
    global playlist_queue
    global current_queue_index
    os.print("[DEBUG] add_rick_playlist_to_queue called. rick_playlist_list.length=" + str(rick_playlist_list.length))
    os.print("[DEBUG] rick_playlist_list: " + str(rick_playlist_list))
    os.print("[DEBUG] playlist_queue before: " + str(playlist_queue))
    while (playlist_queue.length > 0) {
        playlist_queue.remove(0)
    }
    idx = 0
    while (idx < rick_playlist_list.length) {
        song_id = rick_playlist_list.get(idx)
        os.print("[DEBUG] Adding song to queue: " + song_id + " from rick_playlist_list")
        add_song_to_queue(song_id)
        idx += 1
    }
    current_queue_index = 0
    os.print("[DEBUG] playlist_queue after: " + str(playlist_queue))
    if (playlist_queue.length > 0) {
        os.music_start(playlist_queue.get(0))
    } else {
        os.print("[DEBUG] No songs enabled in this playlist!")
    }
}

def add_generic_playlist_1_to_queue() {
    global playlist_queue
    global current_queue_index
    os.print("[DEBUG] add_generic_playlist_1_to_queue called. generic_playlist_list_1.length=" + str(generic_playlist_list_1.length))
    os.print("[DEBUG] generic_playlist_list_1: " + str(generic_playlist_list_1))
    os.print("[DEBUG] playlist_queue before: " + str(playlist_queue))
    while (playlist_queue.length > 0) {
        playlist_queue.remove(0)
    }
    idx = 0
    while (idx < generic_playlist_list_1.length) {
        song_id = generic_playlist_list_1.get(idx)
        os.print("[DEBUG] Adding song to queue: " + song_id + " from generic_playlist_list_1")
        add_song_to_queue(song_id)
        idx += 1
    }
    current_queue_index = 0
    os.print("[DEBUG] playlist_queue after: " + str(playlist_queue))
    if (playlist_queue.length > 0) {
        os.music_start(playlist_queue.get(0))
    } else {
        os.print("[DEBUG] No songs enabled in this playlist!")
    }
}

def add_generic_playlist_2_to_queue() {
    global playlist_queue
    global current_queue_index
    os.print("[DEBUG] add_generic_playlist_2_to_queue called. generic_playlist_list_2.length=" + str(generic_playlist_list_2.length))
    os.print("[DEBUG] generic_playlist_list_2: " + str(generic_playlist_list_2))
    os.print("[DEBUG] playlist_queue before: " + str(playlist_queue))
    while (playlist_queue.length > 0) {
        playlist_queue.remove(0)
    }
    idx = 0
    while (idx < generic_playlist_list_2.length) {
        song_id = generic_playlist_list_2.get(idx)
        os.print("[DEBUG] Adding song to queue: " + song_id + " from generic_playlist_list_2")
        add_song_to_queue(song_id)
        idx += 1
    }
    current_queue_index = 0
    os.print("[DEBUG] playlist_queue after: " + str(playlist_queue))
    if (playlist_queue.length > 0) {
        os.music_start(playlist_queue.get(0))
    } else {
        os.print("[DEBUG] No songs enabled in this playlist!")
    }
}

def add_generic_playlist_3_to_queue() {
    global playlist_queue
    global current_queue_index
    os.print("[DEBUG] add_generic_playlist_3_to_queue called. generic_playlist_list_3.length=" + str(generic_playlist_list_3.length))
    os.print("[DEBUG] generic_playlist_list_3: " + str(generic_playlist_list_3))
    os.print("[DEBUG] playlist_queue before: " + str(playlist_queue))
    while (playlist_queue.length > 0) {
        playlist_queue.remove(0)
    }
    idx = 0
    while (idx < generic_playlist_list_3.length) {
        song_id = generic_playlist_list_3.get(idx)
        os.print("[DEBUG] Adding song to queue: " + song_id + " from generic_playlist_list_3")
        add_song_to_queue(song_id)
        idx += 1
    }
    current_queue_index = 0
    os.print("[DEBUG] playlist_queue after: " + str(playlist_queue))
    if (playlist_queue.length > 0) {
        os.music_start(playlist_queue.get(0))
    } else {
        os.print("[DEBUG] No songs enabled in this playlist!")
    }
}

def add_generic_playlist_4_to_queue() {
    global playlist_queue
    global current_queue_index
    os.print("[DEBUG] add_generic_playlist_4_to_queue called. generic_playlist_list_4.length=" + str(generic_playlist_list_4.length))
    os.print("[DEBUG] generic_playlist_list_4: " + str(generic_playlist_list_4))
    os.print("[DEBUG] playlist_queue before: " + str(playlist_queue))
    while (playlist_queue.length > 0) {
        playlist_queue.remove(0)
    }
    idx = 0
    while (idx < generic_playlist_list_4.length) {
        song_id = generic_playlist_list_4.get(idx)
        os.print("[DEBUG] Adding song to queue: " + song_id + " from generic_playlist_list_4")
        add_song_to_queue(song_id)
        idx += 1
    }
    current_queue_index = 0
    os.print("[DEBUG] playlist_queue after: " + str(playlist_queue))
    if (playlist_queue.length > 0) {
        os.music_start(playlist_queue.get(0))
    } else {
        os.print("[DEBUG] No songs enabled in this playlist!")
    }
}

def add_generic_playlist_5_to_queue() {
    global playlist_queue
    global current_queue_index
    os.print("[DEBUG] add_generic_playlist_5_to_queue called. generic_playlist_list_5.length=" + str(generic_playlist_list_5.length))
    os.print("[DEBUG] generic_playlist_list_5: " + str(generic_playlist_list_5))
    os.print("[DEBUG] playlist_queue before: " + str(playlist_queue))
    while (playlist_queue.length > 0) {
        playlist_queue.remove(0)
    }
    idx = 0
    while (idx < generic_playlist_list_5.length) {
        song_id = generic_playlist_list_5.get(idx)
        os.print("[DEBUG] Adding song to queue: " + song_id + " from generic_playlist_list_5")
        add_song_to_queue(song_id)
        idx += 1
    }
    current_queue_index = 0
    os.print("[DEBUG] playlist_queue after: " + str(playlist_queue))
    if (playlist_queue.length > 0) {
        os.music_start(playlist_queue.get(0))
    } else {
        os.print("[DEBUG] No songs enabled in this playlist!")
    }
}

def add_generic_playlist_6_to_queue() {
    global playlist_queue
    global current_queue_index
    os.print("[DEBUG] add_generic_playlist_6_to_queue called. generic_playlist_list_6.length=" + str(generic_playlist_list_6.length))
    os.print("[DEBUG] generic_playlist_list_6: " + str(generic_playlist_list_6))
    os.print("[DEBUG] playlist_queue before: " + str(playlist_queue))
    while (playlist_queue.length > 0) {
        playlist_queue.remove(0)
    }
    idx = 0
    while (idx < generic_playlist_list_6.length) {
        song_id = generic_playlist_list_6.get(idx)
        os.print("[DEBUG] Adding song to queue: " + song_id + " from generic_playlist_list_6")
        add_song_to_queue(song_id)
        idx += 1
    }
    current_queue_index = 0
    os.print("[DEBUG] playlist_queue after: " + str(playlist_queue))
    if (playlist_queue.length > 0) {
        os.music_start(playlist_queue.get(0))
    } else {
        os.print("[DEBUG] No songs enabled in this playlist!")
    }
}

// Remove the generic add_playlist_to_queue_from_list function

def add_playlist_to_queue_button_pop_playlist_status() {
    os.print("[DEBUG] Play button pressed: pop_playlist_list")
    add_pop_playlist_to_queue()
}
def add_playlist_to_queue_button_rock_playlist_status() {
    os.print("[DEBUG] Play button pressed: rock_playlist_list")
    add_rock_playlist_to_queue()
}
def add_playlist_to_queue_button_rick_playlist_status() {
    os.print("[DEBUG] Play button pressed: rick_playlist_list")
    add_rick_playlist_to_queue()
}
def add_playlist_to_queue_button_generic_playlist_status_1() {
    os.print("[DEBUG] Play button pressed: generic_playlist_list_1")
    add_generic_playlist_1_to_queue()
}
def add_playlist_to_queue_button_generic_playlist_status_2() {
    os.print("[DEBUG] Play button pressed: generic_playlist_list_2")
    add_generic_playlist_2_to_queue()
}
def add_playlist_to_queue_button_generic_playlist_status_3() {
    os.print("[DEBUG] Play button pressed: generic_playlist_list_3")
    add_generic_playlist_3_to_queue()
}
def add_playlist_to_queue_button_generic_playlist_status_4() {
    os.print("[DEBUG] Play button pressed: generic_playlist_list_4")
    add_generic_playlist_4_to_queue()
}
def add_playlist_to_queue_button_generic_playlist_status_5() {
    os.print("[DEBUG] Play button pressed: generic_playlist_list_5")
    add_generic_playlist_5_to_queue()
}
def add_playlist_to_queue_button_generic_playlist_status_6() {
    os.print("[DEBUG] Play button pressed: generic_playlist_list_6")
    add_generic_playlist_6_to_queue()
}
