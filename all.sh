#!/bin/bash

ROOT=$(pwd)

if [ ! -d $ROOT/iso ]; then
  mkdir iso
fi

if [ ! -f $ROOT/iso/grub.img ]; then
  cd $ROOT/iso
  wget http://files.walafc0.org/archhurd/img/grub.img
fi
cd $ROOT
if [ ! -d $ROOT/disk ]; then
  mkdir disk
fi

./install.sh
./launch.sh grub
./launch.sh run
