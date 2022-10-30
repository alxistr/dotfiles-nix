#!/usr/bin/env bash

set -e

(
  read -sr -p "pass: " passwd
  echo $passwd | sudo cryptsetup luksOpen "$1" container -
  mkdir -p /tmp/luks/container

  (
    cd /tmp/luks
    sudo mount /dev/mapper/container ./container
    ranger
    sudo umount ./container
  )

  sudo cryptsetup luksClose container

)
