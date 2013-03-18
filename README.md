Linux Foobar2000 wrapper
========================

This is a script written in Bash to act as a wrapper for [foobar2000](http://www.foobar2000.org/) when 
run under [Wine](http://www.winehq.org/) on Linux.


What is it for?
===============

Foobar2000 is one of those applications that I really like on Windows, and want to use on Linux too. 
Fortunately, it is possible to run it on Linux via Wine. However, there are some issues that arise when 
you want to use it as your default music application, bind some events etc..

This script parses all the commands and runs them properly so that you can integrate foobar2000 with your 
Linux distribution easier.

It will automaticaly translate your local paths to Windows paths (e.g. `/media/drive_d/music` to `D:\music`).


Installation
============

Ubuntu example
--------

For example if you want to allow foobar2000 to open music files by default, you first need to create a Desktop Entry.


1. Copy the script to `/usr/bin/foobar2000` or somewhere else and make sure to make it executable (`chmod a+x foobar2000`)
2. Go to the folder `~/.local/share/applications`
3. Create a file called `foobar2000.desktop` and enter the following text (remember to set the right values)

        [Desktop Entry]
        Type=Application
        Name=foobar2000
        GenericName=Plays music
        Version=1.0
        Encoding=UTF-8
        Terminal=false
        
        # This is where you need to tell where the script is
        Exec=foobar2000 /add
        Comment=foobar2000 music player
        
        # Download an icon and use it
        Icon=/usr/share/foobar2000.svg
        Categories=GNOME;GTK;AudioVideo;Audio;Player;
4. Safe the file
5. If you still don't see "Open With foobar2000" when you right click on a music file, open `mimeapps.list` from the same 
folder and add these lines at the end, in the `[Added Associations]` section:
        
        audio/mp3=foobar2000.desktop;
        audio/flac=foobar2000.desktop;

This should add foobar2000 to the context menu.
