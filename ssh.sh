#!/bin/bash

if ! ps aux | grep "/usr/bin/sshd" | grep -v grep &> /dev/null; then
  sudo systemctl start sshd
fi

if ! ifconfig | grep lo:0 &> /dev/null ; then
  sudo ifconfig lo:0 172.20.0.1
fi

ssh -p 2222 user@127.0.0.1
