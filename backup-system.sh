#!/bin/bash

BACKUP_LISTS="$HOME/scripts/backup-lists"
BACKUP_DIR="$HOME/backup"
ENCRYPTED_DEVICE="/dev/sdb1"	# UUID
BACKUP_DRIVE_DECRYPTED_NAME="backup"

########################
### BASE DIRECTORIES ###
########################
ETC="/etc"
ETC_DEFAULT="$ETC/default"
ETC_IPTABLES="$ETC/iptables"
ETC_MODULES_LOAD_D="$ETC/modules-load.d"
ETC_X11_XORG_CONF_D="$ETC/X11/xorg.conf.d"
HOME_ABS="$HOME/abs"
HOME_SSH="$HOME/.ssh"
HOME_PURPLE="$HOME/.purple"
HOME_MOZILLA="$HOME/.mozilla"
HOME_CONFIG="$HOME/.config"
HOME_DOCUMENTS="$HOME/Documents"
HOME_DOWNLOADS="$HOME/Downloads"
HOME_MUSIC="$HOME/Music"
HOME_PICTURES="$HOME/Pictures"
HOME_SCRIPTS="$HOME/scripts"
HOME_SITES="$HOME/sites"
HOME_PROJECTS="$HOME/projects"
HOME_ANDROID="$HOME/android"
HOME_WORDLISTS="$HOME/wordlists"
HOME_VMS="$HOME/vms"
HOME_ISO="$HOME/iso"

#############
### FILES ###
#############
ETC_FILES="$BACKUP_LISTS/etc.txt"
ETC_DEFAULT_FILES="$BACKUP_LISTS/etc-default.txt"
ETC_IPTABLES_FILES="$BACKUP_LISTS/etc-iptables.txt"
ETC_MODULES_LOAD_D_FILES="$BACKUP_LISTS/etc-modules-load.d.txt"
ETC_X11_XORG_CONF_D_FILES="$BACKUP_LISTS/etc-X11-xorg.conf.d.txt"
HOME_FILES="$BACKUP_LISTS/home.txt"
HOME_ABS_FILES="$BACKUP_LISTS/home-abs.txt"
FILES=""

# $1 == Base directory
# $2 == File list - IF "dummy" rsync whole directory
create_backup_list() {
	if [ "$2" = "dummy" ]; then
		FILES="${FILES} ${1}"
	else
		for file in `cat ${2}`; do
			FILES="${FILES} ${1}/${file}"
		done
	fi
}

create_backup_lists() {
	create_backup_list ${ETC} ${ETC_FILES}
	create_backup_list ${ETC_DEFAULT} ${ETC_DEFAULT_FILES}
	create_backup_list ${ETC_IPTABLES} ${ETC_IPTABLES_FILES}
	create_backup_list ${ETC_MODULES_LOAD_D} ${ETC_MODULES_LOAD_D_FILES}
	create_backup_list ${ETC_X11_XORG_CONF_D} ${ETC_X11_XORG_CONF_D_FILES}
	create_backup_list ${HOME_ABS} "dummy"
	create_backup_list ${HOME_SSH} "dummy"
	create_backup_list ${HOME_PURPLE} "dummy"
	create_backup_list ${HOME_MOZILLA} "dummy"
	create_backup_list ${HOME_CONFIG} "dummy"
	create_backup_list ${HOME_DOCUMENTS} "dummy"
	create_backup_list ${HOME_DOWNLOADS} "dummy"
	create_backup_list ${HOME_MUSIC} "dummy"
	create_backup_list ${HOME_PICTURES} "dummy"
	create_backup_list ${HOME_SCRIPTS} "dummy"
	create_backup_list ${HOME_SITES} "dummy"
	create_backup_list ${HOME_PROJECTS} "dummy"
	create_backup_list ${HOME_ANDROID} "dummy"
	create_backup_list ${HOME_WORDLISTS} "dummy"
	create_backup_list ${HOME_VMS} "dummy"
	create_backup_list ${HOME_ISO} "dummy"
}

backup_files() {
	sudo rsync -avzR ${FILES} ${BACKUP_DIR}
}

mount_decrypted_device() {
	sudo mount "/dev/mapper/${BACKUP_DRIVE_DECRYPTED_NAME}" ${BACKUP_DIR}
}

decrypt_backup_drive() {
	sudo cryptsetup luksOpen ${ENCRYPTED_DEVICE} ${BACKUP_DRIVE_DECRYPTED_NAME}
}

main() {
	if [ ! -e ${ENCRYPTED_DEVICE} ]; then
		echo "!!! CONNECT BACKUP DRIVE FIRST !!!"
		exit 1
	else
		#decrypt_backup_drive
		#mkdir -p ${BACKUP_DIR}
		#mount_decrypted_device
		create_backup_lists
		backup_files
	fi
}

main
