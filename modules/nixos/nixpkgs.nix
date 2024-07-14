{ config, pkgs, lib, ... }:
let unstable = import <nixos-unstable> {}; in
{
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };
  nixpkgs.overlays = [
    ( import ../../overlay )
    ( self: super: {
        # clojure = unstable.clojure;
        cbqn = unstable.cbqn;
    } )
  ];
}
