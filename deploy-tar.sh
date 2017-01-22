#!/bin/bash

IMAGE_PERMISSIONS="644"
SITE_USER="www-data"
SITE_GROUP="$(SITE_USER)"
SITE_USERGROUP="$(SITE_USER):$(SITE_GROUP)"

if [ -f /tmp/site.tar ]; then
	echo "Stopping Apache...."
	service apache2 stop
	cd /var/www/html/optimistic.ninja/public_html
	echo "Removing old static pages..."
	rm -rf *
	echo "Extracting new static pages..."
	tar xvf /tmp/site.tar
	echo "Modifying owner/group of site..."
	chown -R $(SITE_USERGROUP) *
	echo "Changing permissions for images..."
	chmod $(IMAGE_PERMISSIONS) public/images/*
	echo "Starting apache..."
	service apache2 start
fi

