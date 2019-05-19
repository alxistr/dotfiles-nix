{ config, lib, pkgs, ... }: 
{
  imports = [ 
    <nixpkgs/nixos/modules/installer/cd-dvd/iso-image.nix>
    <nixpkgs/nixos/modules/profiles/all-hardware.nix>
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix> 
  ]; 
}
