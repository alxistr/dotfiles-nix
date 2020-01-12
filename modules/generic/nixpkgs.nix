{ config, pkgs, lib, ... }:
{
  config = {
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowBroken = true;
    nixpkgs.overlays = [
      ( import ../../overlay )
    ];
  };
}
