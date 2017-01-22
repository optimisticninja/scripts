#!/bin/bash

SITE_PATH="/var/www/html/optimistic.ninja/public_html"
IMAGE_PATH="public/images"
IMAGE_PERMISSIONS="644"
SITE_USER="www-data"
SITE_GROUP="$SITE_USER"
SITE_USERGROUP="$SITE_USER:$SITE_GROUP"


stop_apache() {
	echo "Stopping Apache...."
	service apache2 stop
}

make_backup() {
	echo "Creating backup..."
	tar cvf site.tar *
	mv site.tar ../backups/`date +"%m-%d-%y-%H%M"`-archive.tar
}

remove_old() {
	echo "Removing old static pages..."
	rm -rf *
}

extract_new() {
	echo "Extracting new static pages..."
	tar xvf $1
}

fix_ownership() {
	echo "Fixing ownership..."
	chown -R $SITE_USERGROUP *
}

fix_permissions() {
	echo "Fixing image permissions..."
	chmod $IMAGE_PERMISSIONS $IMAGE_PATH/*
}

start_apache() {
	echo "Starting apache..."
	service apache2 start
}

# $1 == The location of your tar.
main() {
	if [ -f "$1" ]; then
		stop_apache	
		cd $SITE_PATH
		make_backup
		remove_old
		extract_new $1
		fix_ownership
		fix_permissions
		start_apache
	fi
}

main "$@"
