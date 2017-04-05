#!/bin/sh

#
# Requires cuetools and shntool
#

cuebreakpoints "$1" | shnsplit -o flac "$2"
cuetag.sh "$1" split-*.flac

