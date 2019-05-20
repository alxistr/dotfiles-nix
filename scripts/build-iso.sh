#!/bin/sh

nix-build '<nixpkgs/nixos>' \
    -A config.system.build.isoImage \
    -I nixos-config=./images/iso.nix
