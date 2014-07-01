#!/bin/bash

if [ "$1" = "h" ]; then
    if ! ps aux | grep "/usr/bin/sshd" | grep -v grep &> /dev/null; then
	sudo systemctl start sshd
    fi
    if ! ifconfig | grep lo:0 &> /dev/null ; then
	sudo ifconfig lo:0 172.20.0.1
    fi
    ssh -p 2222 user@127.0.0.1
elif [ "$1" = "g" ]; then
    if [ ! -f /var/run/sshd.pid ]; then
	sudo /etc/rc.d/sshd start
    fi
    ssh -R 2222:127.0.0.1:22 walafc0@172.20.0.1
else
  echo "Wrong usage. $0 [h|g]"
fi
