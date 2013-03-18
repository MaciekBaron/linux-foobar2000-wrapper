#!/bin/bash

### BEGIN LICENSE
# Copyright (C) 2013 Maciej Baron (@maciekbaron)
# This program is free software: you can redistribute it and/or modify it 
# under the terms of the GNU General Public License version 3, as published 
# by the Free Software Foundation.
# 
# This program is distributed in the hope that it will be useful, but 
# WITHOUT ANY WARRANTY; without even the implied warranties of 
# MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR 
# PURPOSE. See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along 
# with this program. If not, see <http://www.gnu.org/licenses/>.
## END LICENSE

##############
#  CONFIG   #
##############

# The command you use to run Foobar2000
FOOBAR="wine \"media/maciek/___/Program Files (x86)/foobar2000/foobar2000.exe\" "

# The location of your music on Windows
WINDOWS_MUSIC="G:\Muzyka"

# The location of your music on Linux
LINUX_MUSIC="media/maciek/local drive/muzyka"



##############
#	SCRIPT   #
##############

# Commands taken from http://wiki.hydrogenaudio.org/index.php?title=Foobar2000:Commandline_Guide

case "$1" in

# Adding a song to the playlist
/add)
		for file in "$@"
		do
			if [ "$file" != "/add" ]
			then
				files="$files \"$file\""
			fi
		done

		files=${files//$LINUX_MUSIC/$WINDOWS_MUSIC}
		files=${files////\\}
		echo $FOOBAR /add $files
		;;

# Invokes the specified main menu command
/command:*)
		echo $FOOBAR /command:\"${1:9:${#1}}\"
		;;
/playlist_command:*)
		echo $FOOBAR /playlist_command:\"${1:18:${#1}}\"
		;;
/playing_command:*)
		echo $FOOBAR /playing_command:\"${1:17:${#1}}\"
		;;
/context_command:*)
		for file in "$@"
			do
				if [ "$file" != "$1" ]
				then
					files="$files \"$file\""
				fi
			done
		files=${files//$LINUX_MUSIC/$WINDOWS_MUSIC}
		files=${files////\\}
		echo $FOOBAR /context_command:\"${1:17:${#1}}\" $files
		;;

# Single commands that do not require parsing
/play|/pause|/playpause|/prev|/next|/rand|/stop|/exit|/show|/hide|/config)
		echo $FOOBAR $1
		;;

--help|-h|/?)
		echo "Author: Maciej Baron

This is a (very) simple script that relays command line commands to Foobar2000 running on Wine.
Ex. ./foobar.sh /add \"media/drive_d/music/Song by Someone.mp3\"

Remember to configure the script!

Available switches:
   /add <list-of-files> - appends the specified files to the current playlist instead of replacing the playlist content and playing them immediately
   /play, /pause, /playpause, /prev, /next, /rand, /stop - playback controls
   /exit - exits foobar2000
   /show, /hide - shows or hides the main foobar2000 window
   /config - opens the Preferences dialog
   /command:<menu command> - invokes the specified main menu command
   /playlist_command:<context menu command> - invokes the specified context menu command on current playlist selection
   /playing_command:<context menu command> - invokes the specified context menu command on currently played track
   /context_command:<context menu command> <files> - invokes the specified context menu command on the specified files"
		;;

# Ignore other commands
*)		
		if [ "$#" -eq "0" ] # No arguments
		then
			echo $FOOBAR
		else
			echo Unrecognised command
			exit 1
		fi
esac
exit 0
