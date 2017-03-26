#!/bin/sh

CURRENT=`xbacklight -get`

if [ $1 == "up" ]; then
	xbacklight -set $CURRENT + 10
elif [ $1 == "down" ]; then
	xbacklight -set $CURRENT - 10
fi

