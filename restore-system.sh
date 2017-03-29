#!/bin/sh

#
# RUN ME ON A LIVE CD AFTER SETTING UP PARTITIONING
#
# Restores system from backup server tarball, type parameter
# selects which machine backup to grab. It will grab the
# -LATEST symlink for that backup.
#
# USAGE: ./restore-system.sh /root/mount/point type /dev/sdX
#
# Where /dev/sdX is your boot device
#

BACKUP_SERVER="cheese"
BACKUP_SERVER_PORT="5222"
BACKUP_SERVER_USER="backup"
SYSTEM_BACKUP_DIR="system"
ROOT_MOUNT="$1"
TYPE="$2"

AHAB="$SYSTEM_BACKUP_DIR/arch-system-ahab-LATEST.tar.gz"
CHEESE="$SYSTEM_BACKUP_DIR/arch-system-cheese-LATEST.tar.gz"
VMSERVER="$SYSTEM_BACKUP_DIR/arch-system-vmserver-LATEST.tar.gz"
NETHERLANDS_VPS="$SYSTEM_BACKUP_DIR/arch-system-netherlands-vps-LATEST.tar.gz"
SITE="$SYSTEM_BACKUP_DIR/arch-system-site-LATEST.tar.gz"

get_system_tar() {
	if [ $TYPE = "ahab" ]; then
		rsync -avz "$BACKUP_USER@$BACKUP_SERVER:$AHAB" -P $BACKUP_SERVER_PORT
	elif [ $TYPE = "cheese" ]; then
		rsync -avz "$BACKUP_USER@$BACKUP_SERVER:$CHEESE" -P $BACKUP_SERVER_PORT
	elif [ $TYPE = "vmserver" ]; then
		rsync -avz "$BACKUP_USER@$BACKUP_SERVER:$VMSERVER" -P $BACKUP_SERVER_PORT
	elif [ $TYPE = "netherlands-vps" ]; then
		rsync -avz "$BACKUP_USER@$BACKUP_SERVER:$NETHERLANDS_VPS" -P $BACKUP_SERVER_PORT
	elif [ $TYPE = "site" ]; then
		rsync -avz "$BACKUP_USER@$BACKUP_SERVER:$SITE" -P $BACKUP_SERVER_PORT
	fi

}

main() {
	cd $ROOT_MOUNT
	get_system_tar
	tar --xattrs -xpfvz
	echo "Please fix /etc/fstab /etc/crypttab and grub before rebooting."
	echo "Done"
}

