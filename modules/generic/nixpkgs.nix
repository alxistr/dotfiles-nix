{ config, pkgs, lib, ... }:
{
  config = {
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowBroken = false;
    nixpkgs.overlays = [
      ( import ../../overlay )
    ];
  };
}
