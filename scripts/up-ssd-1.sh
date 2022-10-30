#!/usr/bin/env bash

set -e

(
  read -sr -p "pass: " passwd
  echo $passwd | sudo cryptsetup luksOpen /dev/sdb2 container-sdb2 -
  echo $passwd | sudo cryptsetup luksOpen /dev/sdb3 container-sdb3 -
  mkdir -p /tmp/luks/{sdb2,sdb3}

  (
    cd /tmp/luks
    sudo mount /dev/mapper/container-sdb2 ./sdb2
    sudo mount /dev/mapper/container-sdb3 ./sdb3
    # echo -e "\033[0;31msession with mounted ssd\033[0m" && bash
    ranger
    sudo umount ./sdb2 ./sdb3

  )

  sudo cryptsetup luksClose container-sdb2
  sudo cryptsetup luksClose container-sdb3

)
