#!/bin/bash

cd /boot/grub
wget -O menu.lst http://files.walafc0.org/archhurd/img/config/menu.lst

cd /etc
wget -O rc.conf     http://files.walafc0.org/archhurd/img/config/rc.conf
wget -O hosts       http://files.walafc0.org/archhurd/img/config/hosts
wget -O locale.gen  http://files.walafc0.org/archhurd/img/config/locale.gen
locale-gen

cd /etc/pacman.d
wget -O mirrorlist  http://files.walafc0.org/archhurd/img/config/mirrorlist

pacman -Syu --noconfirm sudo openssh emacs-nox htop
groupadd sudo
export EDITOR=emacs
visudo
useradd -m -G users,sudo -s /bin/bash user
passwd user

cp /home/user/.bashrc /root
cp /home/user/.bash_profile /root
