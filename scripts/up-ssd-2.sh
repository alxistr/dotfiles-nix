#!/usr/bin/env bash

set -e

(
  read -sr -p "pass: " passwd
  echo $passwd | sudo cryptsetup luksOpen /dev/sdb container-sdb -
  mkdir -p /tmp/luks/sdb

  (
    cd /tmp/luks
    sudo mount /dev/mapper/container-sdb ./sdb
    ranger
    sudo umount ./sdb

  )

  sudo cryptsetup luksClose container-sdb

)
