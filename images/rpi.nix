{ config, pkgs, lib, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/sd-image-aarch64.nix>
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ../modules/generic
    ../modules/nixos
  ] ++ lib.optional (builtins.pathExists ../local-rpi.nix) ../local-rpi.nix;

  disabledModules = [
    <nixpkgs/nixos/modules/profiles/installation-device.nix>
  ];

  nixpkgs.crossSystem = lib.mkIf (builtins.currentSystem != "aarch64-linux") {
    config = "aarch64-unknown-linux-gnu";
    system = "aarch64-linux";
  };

  # sdImage = {
  #   bootSize = 512;
  # };

  own.rpi3bp.enable = true;

}
