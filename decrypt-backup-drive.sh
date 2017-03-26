#!/bin/sh

BACKUP_DEVICE="/dev/sdb1"

sudo cryptsetup luksOpen $BACKUP_DEVICE backup
sudo mount /dev/mapper/backup $HOME/backup
