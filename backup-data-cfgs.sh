#!/bin/bash

#
# Remote server backup, configure to your liking.
#

BACKUP_SERVER="192.168.1.10"
BACKUP_PORT="5222"
BACKUP_USER="jonesy"
BACKUP_LIST="$HOME/scripts/backup-data-cfgs.includes"
BACKUP_DIR="/home/jonesy/backup/"

rsync -avzR -e "ssh -p $BACKUP_PORT" `cat $BACKUP_LIST` "${BACKUP_USER}@${BACKUP_SERVER}:${BACKUP_DIR}"

