#!/bin/sh
#
# Script to disable compton compositor when gaming - need to figure out G-Sync in linux
#
ps cat | grep conky > /dev/null
if [ $? -eq 0 ]; then
	killall compton
else
	compton &
fi
