#!/bin/sh

#
# !! Requires pv to be installed !!
#
# DDing /dev/urandom is slow as balls, use this.
#
# USAGE: ./randomize-disk.sh /dev/sda
#

DISK="$1"
DISK_SIZE=$(</proc/partitions awk '$4=="'"$DISK"'" {print sprintf("%.0f",$3*1024}}')
openssl enc -aes-256-ctr -nosalt \
	-pass pass:"$(dd if=/dev/urandom bs=128 count=1 2>/dev/null | base64)" \
	< /dev/zero |
	pv --progress --eta --rate --bytes --size "$DISK_SIZE" |
	dd of=/dev/"$DISK" bs=2M
