def init() {
    global window = window(400, 250)
    window.center()
    window.mode = "no resize"

    tabs = tabs()
    tabs.fill()
    tabs.tab = 1

    // HOME
    tab1 = container()
    tabs.add(tab1, "Home")

    //Explore
    tab2 = container()
    tabs.add(tab2, "Explore")

    Explore_vbox = vScrollContainer()
    Explore_vbox.fill()
    Explore_vbox.margin(10)
    tab2.add(Explore_vbox)

    Explore_title = label("Explore", 15)
    Explore_vbox.add(Explore_title)


    home_vbox = vScrollContainer()
    home_vbox.fill()
    home_vbox.margin(10)
    tab1.add(home_vbox)

    home_title = label("Home", 15)
    home_vbox.add(home_title)

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


    global home_scroll = vScrollContainer()
    home_scroll.margin(60, 5, 60, 5)
    //home_scroll.theme = "#1A1A1A"
    tab1.add(home_scroll)

    global news_container = container()
    news_container.margin(0,10,"", 10)
    news_container.height = 75
    //news_container.theme = "#FFFFFF"
    news_container.onClick = "gladius"
    home_scroll.add(news_container)  

    global news = costume("music//news",10)
    news.margin("","","","")
    news.size(7)
    news_container.add(news)

    //global play_new_song1 = costume("music//play_now")
    //play_new_song1.margin(100,120,"")
    //play_new_song1.onClick = "new_start"
    //news.add(play_new_song1)



    global song_shown_first = hScrollContainer()
    song_shown_first.margin(15,10,"", 10)
    song_shown_first.height = 75
    //song_shown_first.theme = "#1A1A1A"
    home_scroll.add(song_shown_first)  

    global playbutton1 = container()
    playbutton1.margin("","","",5)
    playbutton1.size(70,70)
    playbutton1.onClick = "diamond_heart"
    //playbutton1.theme = "#FFFFFF"
    song_shown_first.add(playbutton1)

    global song_preview1 = costume("music//diamond-heart", 10)
    song_preview1.margin("","","", 35)
    song_preview1.size(2)
    playbutton1.add(song_preview1)

    global playbutton2 = container()
    playbutton2.margin("","","",15)
    playbutton2.size(70,70)
    playbutton2.onClick = "lost"
    //playbutton2.theme = "#FFFFFF"
    song_shown_first.add(playbutton2)

    global song_preview2 = costume("music//lost", 10)
    song_preview2.margin("","","", 35)
    song_preview2.size(2)
    playbutton2.add(song_preview2)

    global playbutton3 = container()
    playbutton3.margin("","","",15)
    playbutton3.size(70,70)
    playbutton3.onClick = "never_gonna_give_you_up"
    //playbutton3.theme = "#FFFFFF"
    song_shown_first.add(playbutton3)

    global song_preview3 = costume("music//never-gonna-give-you-up", 10)
    song_preview3.margin("","","", 35)
    song_preview3.size(2)
    song_preview3.onClick = "never_gonna_give_you_up"
    playbutton3.add(song_preview3)


    global song_shown_first2 = hScrollContainer()
    song_shown_first2.margin(5,10,"", 10)
    song_shown_first2.height = 75
    //song_shown_first2.theme = "#1A1A1A"
    home_scroll.add(song_shown_first2)

    global playbutton4 = container()
    playbutton4.margin("","","",5)
    playbutton4.size(70,70)
    playbutton4.onClick = "hall_of_fame"
    playbutton4.theme = "#FFFFFF"
    song_shown_first2.add(playbutton4)  

    global song_preview4 = costume("music//hall-of-fame", 10)
    song_preview4.margin("","","", 35)
    song_preview4.size(2)
    playbutton4.add(song_preview4)

    global playbutton5 = container()
    playbutton5.margin("","","",15)
    playbutton5.size(70,70)
    playbutton5.onClick = "hotel_california"
    playbutton5.theme = "#FFFFFF"
    song_shown_first2.add(playbutton5) 

    global song_preview5 = costume("music//hotel-california", 10)
    song_preview5.margin("","","", 35)
    song_preview5.size(2)
    playbutton5.add(song_preview5)

    global playbutton6 = container()
    playbutton6.margin("","","",15)
    playbutton6.size(70,70)
    playbutton6.onClick = "call_of_the_wild"
    playbutton6.theme = "#FFFFFF"
    song_shown_first2.add(playbutton6) 

    global song_preview6 = costume("music//call-of-the-wild", 10)
    song_preview6.margin("","","", 35)
    song_preview6.size(2)
    playbutton6.add(song_preview6)


    home_scroll.scrollUp()

    global song_picture_small = costume("music//" + os.music_song_id, 4)
    song_picture_small.margin("", "", 14, 15)
    song_picture_small.size(1)
    tab1.add(song_picture_small)


    global songname_printed = label("Viva la Vida", 8)
    songname_printed.margin("", 180, 10, 30)
    tab1.add(songname_printed)


    global interpreter_printed = label("Coldplay", 5)
    interpreter_printed.margin("", "", 6, 30)
    tab1.add(interpreter_printed)


    // Music progress
    global song_progress = label("0:00", 5)
    song_progress.margin("","", 13, 120)
    tab1.add(song_progress)


    global song_length = label("4:03", 5)
    song_length.margin("", "", 13, 210)
    tab1.add(song_length)


    global song_bar = costume("#song")
    song_bar.margin(240, 120)
    tab1.add(song_bar)

    global progress = os.music_progress_skip


    //Explore page taskbar down

    music_player2 = container()
    music_player2.margin(225, 5, 5, 5)
    music_player2.theme = "#1A1A1A"
    music_player2.height = 20
    tab2.add(music_player2)


    global play_symbol2 = costume("music//play", 5)
    play_symbol2.margin(225, 35, 5, "")
    play_symbol2.size(15)
    play_symbol2.onClick = "start_music"
    tab2.add(play_symbol2)


    global skip_back2 = costume("music//skip_back", 5)
    skip_back2.margin(225, 55, 5, "")
    skip_back2.size(15)
    skip_back2.onClick = "skip_b_music"
    tab2.add(skip_back2)


    global skip_forward2 = costume("music//skip_forward", 5)
    skip_forward2.margin(225, 15, 5, "")
    skip_forward2.size(15)
    skip_forward2.onClick = "skip_f_music"
    tab2.add(skip_forward2)

    global song_picture_small2 = costume("music//" + os.music_song_id, 4)
    song_picture_small2.margin("", "", 14, 20)
    song_picture_small2.size(1)
    tab2.add(song_picture_small2)


    global songname_printed2 = label("Viva la Vida", 8)
    songname_printed2.margin("", 180, 10, 30)
    tab2.add(songname_printed2)


    global interpreter_printed2 = label("Coldplay", 5)
    interpreter_printed2.margin("", "", 6, 35)
    tab2.add(interpreter_printed2)

    // Music progress
    global song_progress2 = label("0:00", 5)
    song_progress2.margin("","", 13, 125)
    tab2.add(song_progress2)


    global song_length2 = label("4:03", 5)
    song_length2.margin("", "", 13, 215)
    tab2.add(song_length2)


    global song_bar2 = costume("#song")
    song_bar2.margin(240, 120)
    tab2.add(song_bar2)

    //Explore page content

    global explore_scroll = vScrollContainer()
    explore_scroll.margin(40, 5, 60, 5)
    tab2.add(explore_scroll)

    //all songs 
    //viva la vida
    global song_displayed = button()
    song_displayed.margin(5, 5, "", 5)
    song_displayed.theme = "#1A1A1A"
    song_displayed.height = 20
    song_displayed.onClick = "viva_la_vida"
    explore_scroll.add(song_displayed)

    global song_picture1 = costume("music//viva-la-vida", 4)
    song_picture1.margin("", "","", 10)
    song_picture1.size(1)
    song_displayed.add(song_picture1)

    global songtitel_displayed = label("viva la vida", 8)
    songtitel_displayed.margin("","","","")
    songtitel_displayed.align = 0.5
    song_displayed.add(songtitel_displayed)

    global songint_displayed = label("Coldplay", 8)
    songint_displayed.margin("",10,"","")
    songint_displayed.align = 1
    song_displayed.add(songint_displayed)

    //hotel california
    global song_displayed2 = button()
    song_displayed2.margin(5, 5, "", 5)
    song_displayed2.theme = "#1A1A1A"
    song_displayed2.height = 20
    song_displayed2.onClick = "hotel_california"
    explore_scroll.add(song_displayed2)

    global song_picture2 = costume("music//hotel-california", 4)
    song_picture2.margin("", "","", 10)
    song_picture2.size(1)
    song_displayed2.add(song_picture2)

    global songtitel_displayed2 = label("hotel california", 8)
    songtitel_displayed2.margin("","","","")
    songtitel_displayed2.align = 0.5
    song_displayed2.add(songtitel_displayed2)

    global songint_displayed2 = label("Eagles", 8)
    songint_displayed2.margin("",10,"","")
    songint_displayed2.align = 1
    song_displayed2.add(songint_displayed2)

    //lost
    global song_displayed = button()
    song_displayed.margin(5, 5, "", 5)
    song_displayed.theme = "#1A1A1A"
    song_displayed.height = 20
    song_displayed.onClick = "lost"
    explore_scroll.add(song_displayed)

    global song_picture = costume("music//lost", 4)
    song_picture.margin("", "","", 10)
    song_picture.size(1)
    song_displayed.add(song_picture)

    global songtitel_displayed = label("lost", 8)
    songtitel_displayed.margin("","","","")
    songtitel_displayed.align = 0.5
    song_displayed.add(songtitel_displayed)

    global songint_displayed = label("Linkin Park", 8)
    songint_displayed.margin("",10,"","")
    songint_displayed.align = 1
    song_displayed.add(songint_displayed)

    //nothing else matters
    global song_displayed = button()
    song_displayed.margin(5, 5, "", 5)
    song_displayed.theme = "#1A1A1A"
    song_displayed.height = 20
    song_displayed.onClick = "nothing_else_matters"
    explore_scroll.add(song_displayed)

    global song_picture = costume("music//nothing-else-matters", 4)
    song_picture.margin("", "","", 10)
    song_picture.size(1)
    song_displayed.add(song_picture)

    global songtitel_displayed = label("nothing else matters", 8)
    songtitel_displayed.margin("","","","")
    songtitel_displayed.align = 0.5
    song_displayed.add(songtitel_displayed)

    global songint_displayed = label("Metallica", 8)
    songint_displayed.margin("",10,"","")
    songint_displayed.align = 1
    song_displayed.add(songint_displayed)

    //somewhere i belong
    global song_displayed = button()
    song_displayed.margin(5, 5, "", 5)
    song_displayed.theme = "#1A1A1A"
    song_displayed.height = 20
    song_displayed.onClick = "somewhere_i_belong"
    explore_scroll.add(song_displayed)

    global song_picture = costume("music//somewhere-i-belong", 4)
    song_picture.margin("", "","", 10)
    song_picture.size(1)
    song_displayed.add(song_picture)

    global songtitel_displayed = label("somewhere i belong", 8)
    songtitel_displayed.margin("","","","")
    songtitel_displayed.align = 0.5
    song_displayed.add(songtitel_displayed)

    global songint_displayed = label("Linkin Park", 8)
    songint_displayed.margin("",10,"","")
    songint_displayed.align = 1
    song_displayed.add(songint_displayed)

    //everything ends
    global song_displayed = button()
    song_displayed.margin(5, 5, "", 5)
    song_displayed.theme = "#1A1A1A"
    song_displayed.height = 20
    song_displayed.onClick = "everything_ends"
    explore_scroll.add(song_displayed)

    global song_picture = costume("music//everything-ends", 4)
    song_picture.margin("", "","", 10)
    song_picture.size(1)
    song_displayed.add(song_picture)

    global songtitel_displayed = label("everything ends", 8)
    songtitel_displayed.margin("","","","")
    songtitel_displayed.align = 0.5
    song_displayed.add(songtitel_displayed)

    global songint_displayed = label("Architects", 8)
    songint_displayed.margin("",10,"","")
    songint_displayed.align = 1
    song_displayed.add(songint_displayed)

    //hall of fame
    global song_displayed = button()
    song_displayed.margin(5, 5, "", 5)
    song_displayed.theme = "#1A1A1A"
    song_displayed.height = 20
    song_displayed.onClick = "hall_of_fame"
    explore_scroll.add(song_displayed)

    global song_picture = costume("music//hall-of-fame", 4)
    song_picture.margin("", "","", 10)
    song_picture.size(1)
    song_displayed.add(song_picture)

    global songtitel_displayed = label("hall of fame", 8)
    songtitel_displayed.margin("","","","")
    songtitel_displayed.align = 0.5
    song_displayed.add(songtitel_displayed)

    global songint_displayed = label("The Script", 8)
    songint_displayed.margin("",10,"","")
    songint_displayed.align = 1
    song_displayed.add(songint_displayed)

    //call of the wild
    global song_displayed = button()
    song_displayed.margin(5, 5, "", 5)
    song_displayed.theme = "#1A1A1A"
    song_displayed.height = 20
    song_displayed.onClick = "call_of_the_wild"
    explore_scroll.add(song_displayed)

    global song_picture = costume("music//call-of-the-wild", 4)
    song_picture.margin("", "","", 10)
    song_picture.size(1)
    song_displayed.add(song_picture)

    global songtitel_displayed = label("call of the wild", 8)
    songtitel_displayed.margin("","","","")
    songtitel_displayed.align = 0.5
    song_displayed.add(songtitel_displayed)

    global songint_displayed = label("Powerwulf", 8)
    songint_displayed.margin("",10,"","")
    songint_displayed.align = 1
    song_displayed.add(songint_displayed)

    //diamond heart
    global song_displayed = button()
    song_displayed.margin(5, 5, "", 5)
    song_displayed.theme = "#1A1A1A"
    song_displayed.height = 20
    song_displayed.onClick = "diamond_heart"
    explore_scroll.add(song_displayed)

    global song_picture = costume("music//diamond-heart", 4)
    song_picture.margin("", "","", 10)
    song_picture.size(1)
    song_displayed.add(song_picture)

    global songtitel_displayed = label("diamond heart", 8)
    songtitel_displayed.margin("","","","")
    songtitel_displayed.align = 0.5
    song_displayed.add(songtitel_displayed)

    global songint_displayed = label("Alan Walker", 8)
    songint_displayed.margin("",10,"","")
    songint_displayed.align = 1
    song_displayed.add(songint_displayed)

    //never gonna give you up
    global song_displayed = button()
    song_displayed.margin(5, 5, "", 5)
    song_displayed.theme = "#1A1A1A"
    song_displayed.height = 20
    song_displayed.onClick = "never_gonna_give_you_up"
    explore_scroll.add(song_displayed)

    global song_picture = costume("music//never-gonna-give-you-up", 4)
    song_picture.margin("", "","", 10)
    song_picture.size(1)
    song_displayed.add(song_picture)

    global songtitel_displayed = label("never gonna give you up", 8)
    songtitel_displayed.margin("","","","")
    songtitel_displayed.align = 0.5
    song_displayed.add(songtitel_displayed)

    global songint_displayed = label("Rick Astley", 8)
    songint_displayed.margin("",10,"","")
    songint_displayed.align = 1
    song_displayed.add(songint_displayed)

    //above the skies
    global song_displayed = button()
    song_displayed.margin(5, 5, "", 5)
    song_displayed.theme = "#1A1A1A"
    song_displayed.height = 20
    song_displayed.onClick = "above_the_skies"
    explore_scroll.add(song_displayed)

    global song_picture = costume("music//above-the-skies", 4)
    song_picture.margin("", "","", 10)
    song_picture.size(1)
    song_displayed.add(song_picture)

    global songtitel_displayed = label("Above the skies", 8)
    songtitel_displayed.margin("","","","")
    songtitel_displayed.align = 0.5
    song_displayed.add(songtitel_displayed)

    global songint_displayed = label("RedOS-Paulottix", 8)
    songint_displayed.margin("",10,"","")
    songint_displayed.align = 1
    song_displayed.add(songint_displayed)

    //legends
    global song_displayed = button()
    song_displayed.margin(5, 5, "", 5)
    song_displayed.theme = "#1A1A1A"
    song_displayed.height = 20
    song_displayed.onClick = "legends"
    explore_scroll.add(song_displayed)

    global song_picture = costume("music//legends", 4)
    song_picture.margin("", "","", 10)
    song_picture.size(1)
    song_displayed.add(song_picture)

    global songtitel_displayed = label("legends", 8)
    songtitel_displayed.margin("","","","")
    songtitel_displayed.align = 0.5
    song_displayed.add(songtitel_displayed)

    global songint_displayed = label("RedOS-Paulottix", 8)
    songint_displayed.margin("",10,"","")
    songint_displayed.align = 1
    song_displayed.add(songint_displayed)

    //gladius superabit
    global song_displayed = button()
    song_displayed.margin(5, 5,"", 5)
    song_displayed.theme = "#1A1A1A"
    song_displayed.height = 20
    song_displayed.onClick = "gladius"
    explore_scroll.add(song_displayed)

    global song_picture = costume("music//gladius", 4)
    song_picture.margin("", "","", 10)
    song_picture.size(1)
    song_displayed.add(song_picture)

    global songtitel_displayed = label("Gladius Superabit", 8)
    songtitel_displayed.margin("","","","")
    songtitel_displayed.align = 0.5
    song_displayed.add(songtitel_displayed)

    global songint_displayed = label("Paulottix,SunoAi,Citrus", 8)
    songint_displayed.margin("",10,"","")
    songint_displayed.align = 1
    song_displayed.add(songint_displayed)

    //where the mountain ends
    global song_displayed = button()
    song_displayed.margin(5, 5, "", 5)
    song_displayed.theme = "#1A1A1A"
    song_displayed.height = 20
    song_displayed.onClick = "mountain"
    explore_scroll.add(song_displayed)

    global song_picture = costume("music//mountains", 4)
    song_picture.margin("", "","", 10)
    song_picture.size(1)
    song_displayed.add(song_picture)

    global songtitel_displayed = label("where the mountain ends", 8)
    songtitel_displayed.margin("","","","")
    songtitel_displayed.align = 0.5
    song_displayed.add(songtitel_displayed)

    global songint_displayed = label("RedOS-Paulottix", 8)
    songint_displayed.margin("",10,"","")
    songint_displayed.align = 1
    song_displayed.add(songint_displayed)


    //Where the mountain ends progressive house version
    global song_displayed = button()
    song_displayed.margin(5, 5, "", 5)
    song_displayed.theme = "#1A1A1A"
    song_displayed.height = 20
    song_displayed.onClick = "mountain_ends"
    explore_scroll.add(song_displayed)

    global song_picture = costume("music//where_the_mountain_ends_progressive_house_version", 4)
    song_picture.margin("", "","", 10)
    song_picture.size(1)
    song_displayed.add(song_picture)

    global songtitel_displayed = label("Where the m. ends ph", 8)
    songtitel_displayed.margin("","","","")
    songtitel_displayed.align = 0.5
    song_displayed.add(songtitel_displayed)

    global songint_displayed = label("RedOS-Paulottix", 8)
    songint_displayed.margin("",10,"","")
    songint_displayed.align = 1
    song_displayed.add(songint_displayed)

    //no return
    global song_displayed = button()
    song_displayed.margin(5, 5, "", 5)
    song_displayed.theme = "#1A1A1A"
    song_displayed.height = 20
    song_displayed.onClick = "no"
    explore_scroll.add(song_displayed)

    global song_picture = costume("music//no", 4)
    song_picture.margin("", "","", 10)
    song_picture.size(1)
    song_displayed.add(song_picture)

    global songtitel_displayed = label("No Return", 8)
    songtitel_displayed.margin("","","","")
    songtitel_displayed.align = 0.5
    song_displayed.add(songtitel_displayed)

    global songint_displayed = label("RedOS-Paulottix", 8)
    songint_displayed.margin("",10,"","")
    songint_displayed.align = 1
    song_displayed.add(songint_displayed)   

    //That Bass will grow on you ig
    global song_displayed = button()
    song_displayed.margin(5, 5, "", 5)
    song_displayed.theme = "#1A1A1A"
    song_displayed.height = 20
    song_displayed.onClick = "that_bass"
    explore_scroll.add(song_displayed)

    global song_picture = costume("music//that-bass", 4)
    song_picture.margin("", "","", 10)
    song_picture.size(1)
    song_displayed.add(song_picture)

    global songtitel_displayed = label("That Bass will grow on you ig", 8)
    songtitel_displayed.margin("","","","")
    songtitel_displayed.align = 0.5
    song_displayed.add(songtitel_displayed)

    global songint_displayed = label("RedOS-Paulottix", 8)
    songint_displayed.margin("",10,"","")
    songint_displayed.align = 1
    song_displayed.add(songint_displayed)

    //gladius-superabit-v2
    global song_displayed = button()
    song_displayed.margin(5, 5, "", 5)
    song_displayed.theme = "#1A1A1A"
    song_displayed.height = 20
    song_displayed.onClick = "gladius_superabit"
    explore_scroll.add(song_displayed)

    global song_picture = costume("music//gladius-superabit-v2", 4)
    song_picture.margin("", "","", 10)
    song_picture.size(1)
    song_displayed.add(song_picture)

    global songtitel_displayed = label("Gladius Superabit v2", 8)
    songtitel_displayed.margin("","","","")
    songtitel_displayed.align = 0.5
    song_displayed.add(songtitel_displayed)

    global songint_displayed = label("RedOS-Paulottix", 8)
    songint_displayed.margin("",10,"","")
    songint_displayed.align = 1
    song_displayed.add(songint_displayed)

    tab3 = container()
    tabs.add(tab3, "Lyrics")

    //global lyrics_text = label("\mForever trusting\m who we are",8)
    //lyrics_text.margin("",10,"",10)
    //lyrics_text.align = 0
    //lyrics_text.wrap = 1
    //tab3.add(lyrics_text)


    //get lyrics
    
    os.music_get_line()

    global lyrics_container = vScrollContainer()
    lyrics_container.margin(30, 5, 60, 5)
    //lyrics_container.theme = "#1A1A1A"
    tab3.add(lyrics_container)

    global lyrics_line = container()
    lyrics_line.margin(0, 5, "", 5)
    lyrics_line.height = 10
    //lyrics_line.theme = "#FF4060"
    lyrics_container.add(lyrics_line)

    global lyrics_word_text1 = " "

    global lyrics_word1 = label(lyrics_word_text1,12)
    lyrics_word1.onClick = "lyrics1"
    lyrics_line.add(lyrics_word1)

    global lyrics_line2 = container()
    lyrics_line2.margin(20, 5, "", 5)
    lyrics_line2.height = 10
    //lyrics_line2.theme = "#FF4060"
    lyrics_container.add(lyrics_line2)

    global lyrics_word_text2 = " "

    global lyrics_word2 = label(lyrics_word_text2,12)
    lyrics_word2.onClick = "lyrics2"
    lyrics_line2.add(lyrics_word2)

    global lyrics_line3 = container()
    lyrics_line3.margin(20, 5, "", 5)
    lyrics_line3.height = 10
    //lyrics_line3.theme = "#FF4060"
    lyrics_container.add(lyrics_line3)

    global lyrics_word_text3 = "Please start a song"

    global lyrics_word3 = label(lyrics_word_text3,12)
    lyrics_word3.onClick = "lyrics3"
    lyrics_line3.add(lyrics_word3)

    global lyrics_line4 = container()
    lyrics_line4.margin(20, 5, "", 5)
    lyrics_line4.height = 10
    //lyrics_line4.theme = "#FF4060"
    lyrics_container.add(lyrics_line4)

    global lyrics_word_text4 = " "

    global lyrics_word4 = label(lyrics_word_text4,12)
    lyrics_word4.onClick = "lyrics4"
    lyrics_line4.add(lyrics_word4)

    global lyrics_line5 = container()
    lyrics_line5.margin(20, 5, "", 5)
    lyrics_line5.height = 10
    //lyrics_line5.theme = "#FF4060"
    lyrics_container.add(lyrics_line5)

    global lyrics_word_text5 = " "

    global lyrics_word5 = label(lyrics_word_text5,12)
    lyrics_word5.onClick = "lyrics5"
    lyrics_line5.add(lyrics_word5)
    
    lyrics_container.scrollUp()


    //lyrics page taskbar down

    music_player3 = container()
    music_player3.margin(225, 5, 5, 5)
    music_player3.theme = "#1A1A1A"
    music_player3.height = 20
    tab3.add(music_player3)


    global play_symbol3 = costume("music//play", 5)
    play_symbol3.margin(225, 30, 5, "")
    play_symbol3.size(15)
    play_symbol3.onClick = "start_music"
    tab3.add(play_symbol3)


    global skip_back3 = costume("music//skip_back", 5)
    skip_back3.margin(225, 50, 5, "")
    skip_back3.size(15)
    skip_back3.onClick = "skip_b_music"
    tab3.add(skip_back3)


    global skip_forward3 = costume("music//skip_forward", 5)
    skip_forward3.margin(225, 10, 5, "")
    skip_forward3.size(15)
    skip_forward3.onClick = "skip_f_music"
    tab3.add(skip_forward3)

    global song_picture_small3 = costume("music//" + os.music_song_id, 4)
    song_picture_small3.margin("", "", 14, 15)
    song_picture_small3.size(1)
    tab3.add(song_picture_small3)


    global songname_printed3 = label("Viva la Vida", 8)
    songname_printed3.margin("", 180, 10, 30)
    tab3.add(songname_printed3)


    global interpreter_printed3 = label("Coldplay", 5)
    interpreter_printed3.margin("", "", 6, 30)
    tab3.add(interpreter_printed3)


    // Music progress
    global song_progress3 = label("0:00", 5)
    song_progress3.margin("","", 13, 120)
    tab3.add(song_progress3)


    global song_length3 = label("4:03", 5)
    song_length3.margin("", "", 13, 210)
    tab3.add(song_length3)


    global song_bar3 = costume("#song")
    song_bar3.margin(240, 120)
    tab3.add(song_bar3)

    // Add tabs to window
    window.add(tabs)
}



def start_music() {
    os.music_toggle()
}

def skip_f_music() {
    os.music_skip()
}

def skip_b_music() {
    os.music_skip_back()
}

def frame() {
    if (os.music_is_playing) {
        play_symbol.costume = "music//pause"
        play_symbol2.costume = "music//pause"
        play_symbol3.costume = "music//pause"

        global lyrics_word_text1 = os.music_text1
        global lyrics_word_text2 = os.music_text2
        global lyrics_word_text3 = os.music_text3
        global lyrics_word_text4 = os.music_text4
        global lyrics_word_text5 = os.music_text5

        lyrics_word1.text = lyrics_word_text1
        lyrics_word2.text = lyrics_word_text2
        lyrics_word3.text = lyrics_word_text3
        lyrics_word4.text = lyrics_word_text4
        lyrics_word5.text = lyrics_word_text5
    } else {
        play_symbol.costume = "music//play"
        play_symbol2.costume = "music//play"
        play_symbol3.costume = "music//play"        
    }
    //home
    song_progress.text = format_time(os.music_progress)
    song_bar.data = os.music_progress / os.music_length
    song_length.text = format_time(os.music_length)
    songname_printed.text = os.music_name
    interpreter_printed.text = os.music_interpreter
    progress = os.music_progress_skip


    song_picture_small.costume = "music//" + os.music_song_id
    
    //Explore 
    song_progress2.text = format_time(os.music_progress)
    song_bar2.data = os.music_progress / os.music_length
    song_length2.text = format_time(os.music_length)
    songname_printed2.text = os.music_name
    interpreter_printed2.text = os.music_interpreter
    progress = os.music_progress_skip
    song_picture_small2.costume = "music//" + os.music_song_id


    //lyrics
    song_progress3.text = format_time(os.music_progress)
    song_bar3.data = os.music_progress / os.music_length
    song_length3.text = format_time(os.music_length)
    songname_printed3.text = os.music_name
    interpreter_printed3.text = os.music_interpreter
    progress = os.music_progress_skip
    song_picture_small3.costume = "music//" + os.music_song_id


    if(os.mps_skip_status == 1){
        os.music_set_progress(progress)
        os.music_play()
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
def new_start() {
    os.music_start("lost")
}

//all songs 

def viva_la_vida(){
    os.music_start("viva-la-vida")
}
def hotel_california(){
    os.music_start("hotel-california")
}
def lost(){
    os.music_start("lost")
}
def nothing_else_matters(){
    os.music_start("nothing-else-matters")
}
def somewhere_i_belong(){
    os.music_start("somewhere-i-belong")
}
def everything_ends(){
    os.music_start("everything-ends")
}
def hall_of_fame(){
    os.music_start("hall-of-fame")
}
def call_of_the_wild(){
    os.music_start("call-of-the-wild")
}
def diamond_heart(){
    os.music_start("diamond-heart")
}
def never_gonna_give_you_up(){
    os.music_start("never-gonna-give-you-up")
}
def above_the_skies(){
    os.music_start("above-the-skies")
}
def legends(){
    os.music_start("legends")
}
def gladius(){
    os.music_start("gladius")
}
def mountain(){
    os.music_start("mountains")
}
def mountain_ends(){
    os.music_start("where_the_mountain_ends_progressive_house_version")
}
def no(){
    os.music_start("no")
}
def gladius_superabit(){
    os.music_start("gladius-superabit-v2")
}
def that_bass(){
    os.music_start("that-bass")
}

//skip to verse

def lyrics1(){
    os.music_set_progress(os.lyrics_time1)
    os.music_play()
}
def lyrics2(){
    os.music_set_progress(os.lyrics_time2)
    os.music_play()
}
def lyrics3(){
    os.music_set_progress(os.lyrics_time3)
    os.music_play()
}
def lyrics4(){
    os.music_set_progress(os.lyrics_time4)
    os.music_play()
}
def lyrics5(){
    os.music_set_progress(os.lyrics_time5)
    os.music_play()
}
