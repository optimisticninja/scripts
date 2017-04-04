#!/bin/sh
#
# Script to disable compton compositor when gaming - need to figure out G-Sync in linux
#

pgrep compton && killall compton
if [ "$?" -eq 1 ]; then
	compton
fi
