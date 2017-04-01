#!/bin/sh

USER_AT_HOST="$1"
PORT="$2"

if [ ! -z "$USER_AT_HOST" ]; then
	ssh -vTND "$PORT" "$USER_AT_HOST" 
elif [ ! -z "$PORT" ]; then
	echo "USAGE: ./encrypted-socks-tunnel.sh user@server 1337"
fi

