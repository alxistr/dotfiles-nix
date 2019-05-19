{ config, pkgs, lib, ... }:
{
  imports = [ 
    <nixpkgs/nixos/modules/installer/cd-dvd/sd-image-aarch64.nix>
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix> 
  ];

  own.rpi3bp.enable = true;

}
