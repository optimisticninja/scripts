#!/bin/bash

BACKUP_SERVER="cheese"
BACKUP_PORT="5222"
BACKUP_USER="backup"
BACKUP_LISTS="$HOME/scripts/backup-lists"
BACKUP_DIR="/home/backup/"
ENCRYPTED_DEVICE="/dev/mapper/backup"
BACKUP_DRIVE_DECRYPTED_NAME="backup"

########################
### BASE DIRECTORIES ###
########################
ETC="/etc"
ETC_DEFAULT="$ETC/default"
ETC_IPTABLES="$ETC/iptables"
ETC_MODULES_LOAD_D="$ETC/modules-load.d"
ETC_X11_XORG_CONF_D="$ETC/X11/xorg.conf.d"
ETC_PACMAN_D="$ETC/pacman.d"
ETC_PACMAN_D_HOOKS="$ETC_PACMAN_D/hooks"
HOME_ABS="$HOME/abs"
HOME_SSH="$HOME/.ssh"
HOME_PURPLE="$HOME/.purple"
HOME_MOZILLA="$HOME/.mozilla"
HOME_CONFIG="$HOME/.config"
HOME_TIXATI="$HOME/.tixati"
HOME_YED="$HOME/.yEd"
HOME_STEAM="$HOME/.steam"
HOME_DOCUMENTS="$HOME/Documents"
HOME_DOWNLOADS="$HOME/Downloads"
HOME_MUSIC="$HOME/Music"
HOME_PICTURES="$HOME/Pictures"
HOME_VIDEOS="$HOME/Videos"
HOME_SCRIPTS="$HOME/scripts"
HOME_SITES="$HOME/sites"
HOME_PROJECTS="$HOME/projects"
HOME_ANDROID="$HOME/android"
HOME_WORDLISTS="$HOME/wordlists"
HOME_WORKSPACE="$HOME/workspace"
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
ETC_PACMAN_D_FILES="$BACKUP_LISTS/etc-pacman.d.txt"
ETC_PACMAN_D_HOOKS_FILES="$BACKUP_LISTS/etc-pacman.d-hooks.txt"
HOME_FILES="$BACKUP_LISTS/home.txt"
HOME_ABS_FILES="$BACKUP_LISTS/home-abs.txt"
FILES=""

# $1 == Base directory
# $2 == File list - IF "dummy" rsync whole directory
create_backup_list() {
	if [ "$#" -eq 1 ]; then
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
	create_backup_list ${ETC_PACMAN_D} ${ETC_PACMAN_D_FILES}
	create_backup_list ${ETC_PACMAN_D_HOOKS} ${ETC_PACMAN_D_HOOKS_FILES}
	create_backup_list ${HOME_ABS}
	create_backup_list ${HOME_SSH} 
	create_backup_list ${HOME_PURPLE} 
	create_backup_list ${HOME_MOZILLA} 
	create_backup_list ${HOME_CONFIG} 
	create_backup_list ${HOME_TIXATI} 
	create_backup_list ${HOME_YED} 
	create_backup_list ${HOME_STEAM} 
	create_backup_list ${HOME_DOCUMENTS} 
	create_backup_list ${HOME_DOWNLOADS} 
	create_backup_list ${HOME_MUSIC} 
	create_backup_list ${HOME_PICTURES} 
	create_backup_list ${HOME_VIDEOS} 
	create_backup_list ${HOME_SCRIPTS} 
	create_backup_list ${HOME_SITES} 
	create_backup_list ${HOME_PROJECTS} 
	create_backup_list ${HOME_ANDROID} 
	create_backup_list ${HOME_WORDLISTS} 
	create_backup_list ${HOME_WORKSPACE} 
	create_backup_list ${HOME_VMS} 
	create_backup_list ${HOME_ISO} 
}

backup_files() {
	if [ ${BACKUP_SERVER} = "" ]; then
		sudo rsync -avzR ${FILES} ${BACKUP_DIR}
	else
		sudo rsync -avzR ${FILES} "${BACKUP_USER}@${BACKUP_SERVER}:${BACKUP_DIR} -P ${BACKUP_PORT}"
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
			decrypt_backup_drive
			mkdir -p ${BACKUP_DIR}
			mount_decrypted_device
		fi
	fi

	create_backup_lists
	backup_files
}

main
