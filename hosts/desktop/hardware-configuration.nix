{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];

  boot.initrd.availableKernelModules = [
    "ehci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices = {
    "nixos-encrypted" = {
      device = "/dev/disk/by-uuid/e3a1ccdc-d552-4677-9d31-46bbbbf6b804";
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/5999-FA2B";
      fsType = "vfat";
    };

    "/" = {
      device = "/dev/disk/by-uuid/8ab2a017-d1f3-4aa5-8aa4-4c4791994973";
      fsType = "btrfs";
    };

  };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

}
