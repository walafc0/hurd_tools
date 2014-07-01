#!/bin/bash

TASK="taskset 0x00000003"
QEMU=qemu-system-i386

IMG=$(pwd)/disk/hurd.img
SWAP=$(pwd)/disk/swap.img

NET="-net nic,vlan=1,model=pcnet -net user,vlan=1"
OPT="-no-frame -ctrl-grab -smp 2 -m 2048 -enable-kvm"

if [ "$1" = "grub" ]; then
  $QEMU -hda $IMG -fda iso/grub.img -boot a $NET
elif [ "$1" = "run" ]; then
  $TASK $QEMU -hda $IMG -hdb $SWAP $NET $OPT &
else
  echo "Usage: $0 [grub | run]"
fi

exit 0
