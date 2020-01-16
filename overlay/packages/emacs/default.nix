{ nixpkgs ? import <nixpkgs> {} }: 
nixpkgs.callPackage ./emacs.nix {}
