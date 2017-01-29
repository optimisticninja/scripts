#!/bin/bash

# Clean out the distro provided stuff
if [[ -f ~/.vimrc ]]; then
	rm ~/.vimrc
fi
if [[ -f ~/.toprc ]]; then
	rm ~/.toprc
fi
if [[ -f ~/.bashrc ]]; then
	rm ~/.bashrc
fi

cd ~/
git clone git@github.com:optimisticninja/dotfiles

ln -sv ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.toprc ~/.toprc
