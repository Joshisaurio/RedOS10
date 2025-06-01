# Add a song

# Audio

## Download

Download the song as mp3.
Change the file name to fit this format: `song-name.mp3`.
Then add it to the music/songs folder

## Python

Rund the [music.py](music.py) file and enter the song name like this without file extension: `song-name`. It takes some time. It outputs five more lines.

## Scratch

Go to the Music sprite to the Sounds tab and upload all mp3 files in the music/songs/song-name folder.

Show the list music.songs and add all six lines from the python code.

# Lyrics

## Option 1: per verse

Go to https://lrclib.net/ and search for the song (green Synced label).

You have to convert the minutes into seconds

## Option 2: per word

This option is not reliable and needs a lot of editing afterwards.

Go to https://revoldiv.com and upload the mp3 song file. Click "Convert To Text" and wait. Open the developer console (F12 in Chrome) and go to the console. Paste [this code](words.js). The transcribed txt file is probably in your downloads folder.

## Option 3

You can also use your own tool.

## Scratch

The lyrics have to be in the following format. Lines are separated by an empty line.

```
timestamp in seconds
word/line
timestamp in seconds
word/line

timestamp in seconds
word/line
timestamp in seconds
word/line

```

Add the lyrics to the end of the music.text list (in the Music sprite). Make sure that there is an empty item (empty line) before and after your song.

Replace the `index of ...` items in the music.songs list.

# Testing

You can test it by clicking the code in the top left in the Music sprite.

Use the left and right arrow keys to skip.
