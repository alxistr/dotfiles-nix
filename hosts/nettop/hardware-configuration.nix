{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/acb8824c-4050-40f6-83d4-34a46f8164ac";
      fsType = "btrfs";
    };

  boot.initrd.luks.devices."nixos-encrypted".device = "/dev/disk/by-uuid/508f5923-d0a4-48c7-bd82-1f2b730d9188";

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/9974-0879";
      fsType = "vfat";
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 1;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

}
