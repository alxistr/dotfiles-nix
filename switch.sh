#!/usr/bin/env bash

basepath=nixos/hosts
target=nixos/host
host=$(ls $basepath | fzf)
if [ ! -z "$host" ]; then
    echo "switch to $host"
    rm -rf $target
    ln -s $(realpath $basepath/$host) $target
    ls -l $target
fi
