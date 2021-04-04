{ config, lib, pkgs, ... }:

{
  imports = [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usb_storage"
    "usbhid"
    "sd_mod"
    "nvme"
  ];
  boot.kernelModules = [
    "kvm-intel"
    "r8125"
  ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    r8125
  ];

  boot.initrd.luks = {
    reusePassphrases = true;
    devices = {
      "nixos-encrypted".device = "/dev/disk/by-uuid/508f5923-d0a4-48c7-bd82-1f2b730d9188";
      "data".device = "/dev/disk/by-uuid/a0dc4c66-e374-43e3-8279-ba4622f63455";
      "dataf".device = "/dev/disk/by-uuid/5d0d55c1-2c70-41dd-abcb-cd15640d9547";
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/9974-0879";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/disk/by-uuid/acb8824c-4050-40f6-83d4-34a46f8164ac";
      fsType = "btrfs";
    };
    "/mnt/dataf/" = {
      device = "/dev/disk/by-uuid/a4a9d2fe-bf1a-435b-8e6a-f152735d863c";
      fsType = "btrfs";
    };
    "/mnt/data/" = {
      device = "/dev/disk/by-uuid/0260de44-87ec-4ec0-a5fc-328f9e00d782";
      fsType = "btrfs";
    };
  };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

}
