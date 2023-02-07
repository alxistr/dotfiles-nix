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
    {
      device = "/dev/disk/by-uuid/b71084ad-e438-465d-a113-6a7637281963";
      fsType = "btrfs";
    };

  boot.initrd.luks.devices."nixos-encrypted".device = "/dev/disk/by-uuid/cd115cd8-ae99-4017-bd40-5575f8dc3110";

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/DEC9-F715";
      fsType = "vfat";
    };

  swapDevices = [ ];

  nix.settings.max-jobs = lib.mkDefault 1;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

}
