#!/bin/bash

# 
# TODO: Test this actually works after revamp/remote server. Damn backup server needs to finish randomizing.
# 

BACKUP_SERVER="cheese"
BACKUP_PORT="5222"
BACKUP_USER="backup"
BACKUP_LISTS="$HOME/scripts/backup-system.includes"
BACKUP_DIR="/home/backup/"
ENCRYPTED_DEVICE="/dev/mapper/backup"
BACKUP_DRIVE_DECRYPTED_NAME="backup"

backup_files() {
	if [ ${BACKUP_SERVER} = "" ]; then
		sudo rsync -avzR --files-from=${BACKUP_LIST} ${BACKUP_DIR}
	else
		sudo rsync -avzR --files-from=${BACKUP_LIST} ${FILES} "${BACKUP_USER}@${BACKUP_SERVER}:${BACKUP_DIR} -P ${BACKUP_PORT}"
	fi
}

mount_decrypted_device() {
	sudo mount "/dev/mapper/${BACKUP_DRIVE_DECRYPTED_NAME}" ${BACKUP_DIR}
}

decrypt_backup_drive() {
	sudo cryptsetup luksOpen ${ENCRYPTED_DEVICE} ${BACKUP_DRIVE_DECRYPTED_NAME}
}

main() {

	if [ ${BACKUP_SERVER} = "" ]; then
		if [ ! -e ${ENCRYPTED_DEVICE} ]; then
			echo "!!! CONNECT BACKUP DRIVE FIRST (Hit enter when ready) !!!"
			read
			decrypt_backup_drive
			mkdir -p ${BACKUP_DIR}
			mount_decrypted_device
		fi
	fi

	create_backup_lists
	backup_files
}

main
