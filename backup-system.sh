#!/bin/bash

BACKUP_LISTS="$HOME/scripts/backup-lists"
BACKUP_DIR="$HOME/backup"

########################
### BASE DIRECTORIES ###
########################
ETC="/etc"
ETC_DEFAULT="$ETC/default"
ETC_IPTABLES="$ETC/iptables"
ETC_MODULES_LOAD_D="$ETC/modules-load.d"
ETC_X11_XORG_CONF_D="$ETC/X11/xorg.conf.d"

#############
### FILES ###
#############
ETC_FILES="$BACKUP_LISTS/etc.txt"
ETC_DEFAULT_FILES="$BACKUP_LISTS/etc-default.txt"
ETC_IPTABLES_FILES="$BACKUP_LISTS/etc-iptables.txt"
ETC_MODULES_LOAD_D_FILES="$BACKUP_LISTS/etc-modules-load.d.txt"
ETC_X11_XORG_CONF_D_FILES="$BACKUP_LISTS/etc-X11-xorg.conf.d.txt"
FILES=""

# $1 == Base directory
# $2 == File list
create_backup_list() {
	for file in `cat ${2}`; do
		FILES="${FILES} $1/${file}"
	done
}

create_backup_lists() {
	create_backup_list ${ETC} ${ETC_FILES}
	create_backup_list ${ETC_DEFAULT} ${ETC_DEFAULT_FILES}
	create_backup_list ${ETC_IPTABLES} ${ETC_IPTABLES_FILES}
	create_backup_list ${ETC_MODULES_LOAD_D} ${ETC_MODULES_LOAD_D_FILES}
	create_backup_list ${ETC_X11_XORG_CONF_D} ${ETC_X11_XORG_CONF_D_FILES}
}

backup_files() {
	sudo rsync -avzR ${FILES} ${BACKUP_DIR}
}

main() {
	create_backup_lists
	backup_files
}

main
