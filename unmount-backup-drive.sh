#!/bin/sh

sudo sync
sudo umount ~/backup
sudo cryptsetup close /dev/mapper/backup

