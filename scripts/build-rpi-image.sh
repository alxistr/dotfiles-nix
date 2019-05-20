#!/bin/sh

nix-build '<nixpkgs/nixos>' \
    -A config.system.build.sdImage \
    -I nixos-config=./images/rpi.nix
