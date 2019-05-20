{ config, pkgs, ... }:
{ 
  imports = [ 
    <nixpkgs/nixos/modules/installer/cd-dvd/sd-image-aarch64.nix>
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix> 
    ../modules/generic
    ../modules/nixos
  ];

  networking.hostName = "raspberry";

  own = {
    ssh = {
      enable = true; 
    };
    docker.enable = true; 
    disable-docs = true; 
    rpi3bp.enable = true; 
  };

}
