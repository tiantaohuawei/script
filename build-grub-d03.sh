#!/bin/bash

GRUB_DIR=$PWD

INSTALL=${GRUB_DIR}/install

#make distclean &&
./autogen.sh &&
./configure --prefix=$INSTALL \
	--with-platform=efi \
	--disable-werror \
	--build=x86_64-suse-linux-gnu \
	--target=aarch64-linux-gnu \
	--host=x86_64-suse-linux-gnu &&
make -j${CORENUM} &&
make install &&
$INSTALL/bin/grub-mkimage -v \
	-o grubaa64.efi \
	-O arm64-efi \
	-p / \
	boot chain configfile efinet ext2 fat iso9660 gettext help hfsplus loadenv lsefi normal ntfs ntfscomp part_gpt part_msdos read search search_fs_file search_fs_uuid search_label terminal terminfo tftp linux

