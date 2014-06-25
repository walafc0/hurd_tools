#!/bin/bash

MP=/mnt
LOOP=/dev/loop0
IMG=disk/hurd.img

function _find_block_number()
{
  NBLOCK=$(echo $(sudo fdisk -u=sectors -l /dev/loop0 | grep loop0p1 | awk '{print $4}') '*' 1024 / 4096 | bc)
}

echo -n "Image size: "
read SIZE
# Create image and partition
qemu-img create -f raw disk/swap.img 1G
mkswap disk/swap.img
qemu-img create -f raw $IMG $(echo $SIZE)G
losetup $LOOP $IMG
cfdisk $LOOP
losetup -d $LOOP

sleep 1

# Format and install 
losetup -o 32256 $LOOP $IMG
_find_block_number
mkfs.ext2 -b 4096 -I 128 -o hurd $LOOP $NBLOCK
mount -o loop $LOOP $MP
mkdir $MP/var/lib/pacman -p
pacman --noconfirm --config pachurd.conf -Sy
pacman --noconfirm --config pachurd.conf -S base base-devel
cp -a $MP/lib/grub/i386-pc/* $MP/boot/grub/
umount $MP
losetup -d $LOOP
