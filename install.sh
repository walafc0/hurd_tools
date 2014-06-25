#!/bin/bash

MP=/mnt
LOOP=/dev/loop0
IMG=disk/hurd.img

# Create image and partition
qemu-img create -f raw disk/swap.img 1G
mkswap disk/swap.img
qemu-img create -f raw $IMG 1G
losetup $LOOP $IMG
cfdisk $LOOP
losetup -d $LOOP

sleep 1

# Format and install 
losetup -o 32256 $LOOP $IMG
mkfs.ext2 -b 4096 -I 128 -o hurd $LOOP 261048
mount -o loop $LOOP $MP
mkdir $MP/var/lib/pacman -p
pacman --noconfirm --config pachurd.conf -Sy
pacman --noconfirm --config pachurd.conf -S base base-devel
cp -a $MP/lib/grub/i386-pc/* $MP/boot/grub/
umount $MP
losetup -d $LOOP
