#!/bin/bash

# Remote stuff
BACKUP_SERVER="mediapc"
BACKUP_PORT="5222"
BACKUP_USER="jonesy"
BACKUP_DIR="/home/jonesy/backup/"

# Local stuff
backdest=$HOME/backup
pc=${HOSTNAME}
distro=arch
type=system
date=$(date "+%F")
backupfile="$backdest/$distro-$type-$pc-$date.tar.gz"
excdir="$HOME/scripts"
exclude_file="$excdir/tar-filesystem.excludes"

# Check if chrooted prompt.
echo -n "First chroot from a LiveCD.  Are you ready to backup? (y/n): "
read executeback

# Check if exclude file exists
if [ ! -f $exclude_file ]; then
  echo -n "No exclude file exists, continue? (y/n): "
  read continue
  if [ $continue == "n" ]; then exit; fi
fi

if [ $executeback = "y" ]; then
  sudo tar --exclude-from=$exclude_file --xattrs -czpvf $backupfile /
  rsync -avz -e "ssh -p $BACKUP_PORT" "$backupfile" "${BACKUP_USER}@${BACKUP_SERVER}:${BACKUP_DIR}" && rm -f "$backupfile"
fi
