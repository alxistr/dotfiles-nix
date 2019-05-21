{ config, pkgs, lib, ... }:
{ 
  imports = [ 
    <nixpkgs/nixos/modules/installer/cd-dvd/sd-image-aarch64.nix>
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix> 
    ../modules/generic
    ../modules/nixos
  ] ++ lib.optional (builtins.pathExists ../secrets-rpi.nix) ../secrets-rpi.nix;

  nixpkgs.crossSystem = lib.mkIf (builtins.currentSystem != "aarch64-linux") {
    config = "aarch64-unknown-linux-gnu"; 
    system = "aarch64-linux"; 
  };

  networking.hostName = "raspberry";

  sdImage = {
    bootSize = 512;
  };

  boot.loader.generic-extlinux-compatible.configurationLimit = 1;

  own = {
    ssh = {
      enable = true; 
    };
    docker.enable = true; 
    disable-docs = true; 
    rpi3bp.enable = true; 
  };

}
