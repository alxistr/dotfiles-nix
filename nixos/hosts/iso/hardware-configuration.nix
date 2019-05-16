{ config, lib, pkgs, ... }: 
{
  imports = [ 
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-base.nix>
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix> 
  ];

  boot.initrd.availableKernelModules = [ 
    "xhci_pci" 
    "ahci" 
    "usb_storage" 
    "usbhid" 
    "sd_mod" 
  ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

}
