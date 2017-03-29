#!/bin/bash
#
# Requires wget be installed.
#
# Pass in the architecture you want to the script
#   i.e i386-elf
#   i.e x86_64-elf
#   i.e arm-eabi

SOURCE_PATH="$HOME/src"

BINUTILS_VERSION="2.26"
BINUTILS_TARBALL="binutils-$BINUTILS_VERSION.tar.gz"
BINUTILS_LINK="ftp://ftp.gnu.org/gnu/binutils/$BINUTILS_TARBALL"

GCC_VERSION="6.3.0"
GCC_TARBALL="gcc-$GCC_VERSION.tar.gz"
GCC_LINK="ftp://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION/$GCC_TARBALL"

PREFIX="$HOME/opt/cross"
TARGET=$1
PATH="$PREFIX/bin:$PATH"

MAKE="make -j9"

download_sources() {
	mkdir -p $SOURCE_PATH
	cd $SOURCE_PATH
	wget $BINUTILS_LINK 
	wget $GCC_LINK
}

extract_sources() {
	tar xvzf $BINUTILS_TARBALL
	tar xvzf $GCC_TARBALL
}

get_dependencies() {
	cd $SOURCE_PATH/gcc-$GCC_VERSION
	contrib/download_prerequisites
}

build_binutils() {
	cd $SOURCE_PATH
	mkdir build-binutils
	cd build-binutils
	../binutils-$BINUTILS_VERSION/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
	$MAKE
	$MAKE install
}

setup_path() {
	echo "PATH=$PATH:~/opt/cross/bin" >> $HOME/.bashrc
	. $HOME/.bashrc
}

build_gcc() {
	cd $SOURCE_PATH
	which -- $TARGET-as || echo $TARGET-as is not in the PATH
	
	mkdir build-gcc
	cd build-gcc
	../gcc-$GCC_VERSION/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
	$MAKE all-gcc
	$MAKE all-target-libgcc
	$MAKE install-gcc
	$MAKE install-target-libgcc
}

main() {
	download_sources
	extract_sources
	get_dependencies
	build_binutils
	setup_path
	build_gcc
	"$TARGET-gcc" -v
}

if [ $# -eq 0 ]; then
	echo "USAGE: ./cross-compiler-install.sh <architecture>"
	exit 1
fi

main
