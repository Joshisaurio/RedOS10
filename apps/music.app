def init() {
    global song_ids = list(       "viva-la-vida", "hotel-california", "lost",        "nothing-else-matters", "somewhere-i-belong", "everything-ends", "hall-of-fame", "call-of-the-wild", "diamond-heart", "never-gonna-give-you-up", "above-the-skies", "legends",         "gladius",                 "mountains",               "where_the_mountain_ends_progressive_house_version", "no",              "that-bass",                     "gladius-superabit-v2")
    global song_names = list(     "Viva La Vida", "Hotel California", "Lost",        "Nothing Else Matters", "Somewhere I Belong", "Everything Ends", "Hall Of Fame", "Call Of The Wild", "Diamond Heart", "Never Gonna Give You Up", "Above The Skies", "Legends",         "Gladius Superabit",       "Where The Mountain Ends", "Where The M. Ends Ph",                              "No Return",       "That Bass Will Grow On You Ig", "Gladius Superabit V2")
    global song_interprets = list("Coldplay",     "Eagles",           "Linkin Park", "Metallica",            "Linkin Park",        "Architects",      "The Script",   "Powerwulf",        "Alan Walker",   "Rick Astley",             "RedOS-Paulottix", "RedOS-Paulottix", "Paulottix,SunoAi,Citrus", "RedOS-Paulottix",         "RedOS-Paulottix",                                   "RedOS-Paulottix", "RedOS-Paulottix",               "RedOS-Paulottix"     )
    global window = window(400, 250)
    window.minSize(400, 250)
    window.center()

    global current_queue_index = 0
    global playlist_queue = song_ids

    tabs = tabs()
    tabs.marginBottom = 30
    tabs.fill()
    tabs.tab = 4
    window.add(tabs)
    
    global tab1 = container()
    tabs.add(tab1, "Home")
    global tab2 = container()
    tabs.add(tab2, "Explore")
    global tab3 = container()
    tabs.add(tab3, "Lyrics")
    global tab4 = container()
    tabs.add(tab4, "Playlists")
    
    // --- Home Tab ---
    setup_home_tab(tab1)

    // --- Explore Tab ---
    setup_explore_tab(tab2)

    // --- Lyrics Tab ---
    setup_lyrics_tab(tab3)
    
    // --- Playlists Tab ---
    setup_playlists_tab(tab4)

    // --- Player Bar ---
    bottom_container = container()
    bottom_container.margin("", 0, 0, 0)
    bottom_container.size("fill", 30)
    bottom_container.theme = 0.07
    window.add(bottom_container)

    music_player = container()
    music_player.margin(5)
    music_player.theme = 0.1
    music_player.height = 20
    bottom_container.add(music_player)

    global skip_forward = costume("music//skip_forward", 5)
    skip_forward.margin("", 10, "", "")
    skip_forward.size(15)
    skip_forward.onClick = "play_next_in_queue()"
    music_player.add(skip_forward)

    global play_symbol = costume("music//play", 5)
    play_symbol.margin("", 30, "", "")
    play_symbol.size(15)
    play_symbol.onClick = "os.music_toggle()"
    music_player.add(play_symbol)

    global skip_back = costume("music//skip_back", 5)
    skip_back.margin("", 50, "", "")
    skip_back.size(15)
    skip_back.onClick = "skip_b_music()"
    music_player.add(skip_back)

    global song_picture_small = costume("music//viva-la-vida", 4)
    song_picture_small.margin("", "", "", 15)
    song_picture_small.size(1)
    music_player.add(song_picture_small)

    global songname_printed = label("Viva la Vida", 8)
    songname_printed.margin("", "", 5, 30)
    music_player.add(songname_printed)

    global interpreter_printed = label("Coldplay", 5)
    interpreter_printed.margin("", "", 1, 30)
    music_player.add(interpreter_printed)

    global song_progress = label("0:00", 5)
    song_progress.width = 175
    song_progress.margin("", 0, 8, "")
    music_player.add(song_progress)

    global song_length = label("4:03", 5, 1)
    song_length.margin("", 75, 8, "")
    music_player.add(song_length)

    global song_bar = costume("#song")
    song_bar.size(100, 0)
    song_bar.margin("", 75, 5, "")
    music_player.add(song_bar)

    global progress = os.music_progress_skip

    global last_mps_skip_status = os.mps_skip_status
}

def setup_home_tab(tab) {
    home_vbox = vScrollContainer()
    home_vbox.margin(30, 5)
    tab.add(home_vbox)

    news_container = container()
    news_container.margin(0,10,"", 10)
    news_container.height = 75
    news_container.onClick = "explore_click_song(\"gladius\")"
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
    
    add_song_preview(song_shown_first, "diamond-heart")
    add_song_preview(song_shown_first, "lost")
    add_song_preview(song_shown_first, "never-gonna-give-you-up")

    song_shown_first2 = hScrollContainer()
    song_shown_first2.margin(5,10,"", 10)
    song_shown_first2.height = 75
    home_vbox.add(song_shown_first2)

    add_song_preview(song_shown_first2, "hall-of-fame")
    add_song_preview(song_shown_first2, "hotel-california")
    add_song_preview(song_shown_first2, "call-of-the-wild")

    home_vbox.scrollUp()
}

def setup_explore_tab(tab) {
    explore_scroll = vScrollContainer()
    explore_scroll.margin(10, 5)
    tab.add(explore_scroll)

    // Add all the songs to the explore list
    i = 0
    while (i < song_ids.length) {
        create_song_entry(explore_scroll, song_ids.get(i), song_names.get(i), song_interprets.get(i))
        i += 1
    }
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
    playlists_vbox.margin(37, 5, 5)
    tab.add(playlists_vbox)

    top_container = container()
    top_container.margin(0, 0, "", 0)
    top_container.size("fill", 30)
    top_container.theme = 0.07
    tab.add(top_container)

    add_button = button("Add New Playlist", "add_playlist_clicked()")
    add_button.fill()
    add_button.margin(5)
    top_container.add(add_button)

    global playlists = list()

    add_playlist_preview("music//playlist-all", "All Songs", song_ids.copy())
    add_playlist_preview("music//playlist-red", "Red OS Originals", list("above-the-skies", "legends", "gladius", "mountains", "where_the_mountain_ends_progressive_house_version", "no", "that-bass", "gladius-superabit-v2"))
    add_playlist_preview("music//playlist-pop", "Pop", list("viva-la-vida", "hotel-california", "never-gonna-give-you-up", "diamond-heart"))
    add_playlist_preview("music//playlist-rock", "Rock", list("viva-la-vida", "somewhere-i-belong", "lost", "hall-of-fame", "everything-ends"))
    add_playlist_preview("music//playlist-metal", "Heavy Metal", list("nothing-else-matters", "call-of-the-wild"))
}

def frame() {
    if (os.music_is_playing) {
        play_symbol.costume = "music//pause"
    } else {
        play_symbol.costume = "music//play"
    }
    
    // Player Bar
    song_progress.text = format_time(os.music_progress)
    song_length.text = format_time(os.music_length)
    song_bar.data = os.music_progress / os.music_length
    songname_printed.text = os.music_name
    interpreter_printed.text = os.music_interpreter
    song_picture_small.costume = "music//" + os.music_song_id
    
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

    if (os.music_length - os.music_progress < 0.1) {
        os.music_start(playlist_queue.get(playlist_queue.index(os.music_song_id) + 1))
        os.music_set_progress(0) 
    }
}

// ---------------------------------------------------
// --              REUSABLE HELPER FUNCTIONS        --
// ---------------------------------------------------

def create_song_entry(parent, song_id, song_title, interpreter) {
    // Creates a single song entry button for the Explore page.
    song_button = button()
    song_button.margin(5, 5, "", 5)
    song_button.theme = 0.1
    song_button.height = 20
    song_button.onClick = "explore_click_song(\"" + song_id + "\")"
    parent.add(song_button)

    song_picture = costume("music//" + song_id, 4)
    song_picture.margin("", "","", 10)
    song_picture.size(1)
    song_button.add(song_picture)

    title_label = label(song_title, 8)
    title_label.margin("","","",30)
    song_button.add(title_label)

    interpreter_label = label(interpreter, 8)
    interpreter_label.margin("",10,"","")
    interpreter_label.align = 1
    song_button.add(interpreter_label)
}

def add_song_preview(parent, song_id) {
    // Creates a song preview element for the Home page.
    playbutton = container()
    playbutton.margin("","","",15)
    playbutton.size(70,70)
    playbutton.onClick = "explore_click_song(\"" + song_id + "\")"
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

def add_playlist_preview(costume_name, playlist_name, playlist_songs) {
    // Creates a playlist preview element for the Playlists page.
    if (playlists.length % 3 == 0) {
        global playlist_row = hScrollContainer()
        playlist_row.margin(15,10,"", 10)
        playlist_row.height = 75
        playlists_vbox.add(playlist_row)
    }
    
    playlist_container = container()
    playlist_container.margin("","","",15)
    playlist_container.size(70,70)
    playlist_container.onClick = "open_playlist_details(\"" + playlist_name + "\", \"" + costume_name + "\", " + playlists.length + ")"

    playlist_costume = costume(costume_name, 10)
    playlist_costume.size(2)
    playlist_container.add(playlist_costume)
    
    playlist_row.add(playlist_container)

    playlists.add(playlist_songs)

}

// ---------------------------------------------------
// --              PLAYLIST FUNCTIONS               --
// ---------------------------------------------------

def add_playlist_clicked() {
    add_playlist_preview("music//playlist-my", "My Playlist " + playlists.length, list())
    add_playlist_preview("music//playlist-my", "My Playlist " + playlists.length, list())
}

def open_playlist_details(playlist_name, cover_image, index) {
    current_playlist_window = window(260, 200)
    current_playlist_window.mode = "no resize"
    current_playlist_window.title = playlist_name
    current_playlist_window.center()

    add_playlist_to_queue_button = button("Play Playlist", "add_playlist_to_queue(" + index + ")")
    add_playlist_to_queue_button.margin("","",0,"")
    add_playlist_to_queue_button.theme = "#FF4060"
    current_playlist_window.add(add_playlist_to_queue_button)

    songs_container = vScrollContainer()
    songs_container.margin(10, 5, 25)
    songs_container.fill()
    current_playlist_window.add(songs_container)

    // Determine which playlist list to use
    playlist_list = playlists.get(index)
    global playlist_switches = list()

    i = 0
    while (i < song_ids.length) {
        song_button = button()
        song_button.margin(5, 5, 5, 5)
        song_button.theme = 0.1
        song_button.height = 20
        songs_container.add(song_button)

        song_picture = costume("music//" + song_ids.get(i), 4)
        song_picture.margin("", "", "", 10)
        song_picture.size(1)
        song_button.add(song_picture)

        name_label = label(song_names.get(i), 8)
        name_label.margin("", "", "", 25)
        name_label.align = 0
        song_button.add(name_label)

        interpreter_label = label(song_interprets.get(i), 8)
        interpreter_label.margin("", 30, "", "")
        interpreter_label.align = 1
        song_button.add(interpreter_label)

        song_switch = switch()
        song_switch.align = 0.9
        song_switch.size = 8
        song_switch.height = "shrink"
        song_switch.margin(2)
        if (playlist_list.index(song_ids.get(i)) > -1) {
            song_switch.state = 1
        } else {
            song_switch.state = 0
        }
        song_switch.onClick = "playlist_switch(" + index + ", " + i + ")"
        song_button.add(song_switch)
        playlist_switches.add(song_switch)

        i += 1
    }
}

def playlist_switch(index, i) {
    if (playlist_switches.get(i).state) {
        // Add if not present
        if (playlists.get(index).index(song_ids.get(i)) == -1) {
            playlists.get(index).add(song_ids.get(i))
        }
    } else {
        // Remove if present
        idx = playlists.get(index).index(song_ids.get(i))
        if (idx != -1) {
            playlists.get(index).remove(idx)
        }
    }
}

def skip_b_music() {
    if (playlist_queue.index(os.music_song_id) <= 0) {
        os.music_start(playlist_queue.get(playlist_queue.length - 1))
    } else {
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

def explore_click_song(song) {
    if (playlist_queue.length == 0) {
        playlist_queue.add(song)
    } else {
        if (playlist_queue.index(song) > -1) {
            playlist_queue.delete(get_index_by_song_id(song))
        }
        playlist_queue.insert(song, get_index_by_song_id(os.music_song_id) + 1)
    }
    os.music_start(song)
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

def play_next_in_queue() {
    if(playlist_queue.index(os.music_song_id) >= playlist_queue.length - 1) { 
        os.music_start(playlist_queue.get(0)) 
    } else {
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

def add_playlist_to_queue(index) {
    global playlist_queue
    global current_queue_index
    playlist_queue = playlists.get(index).copy()
    current_queue_index = 0
    if (playlist_queue.length > 0) {
        os.music_start(playlist_queue.get(0))
    } else {
        os.print("No songs enabled in this playlist!")
    }
}
