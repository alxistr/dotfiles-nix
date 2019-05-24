{ config, pkgs, lib, ... }:
let cfg = config.own.rpi3bp; in
with lib; with types;
{
  options.own.rpi3bp = {
    enable = mkEnableOption "rpi3bp";
  };

  config = mkIf cfg.enable {
    boot.kernelPackages = pkgs.linuxPackages_latest;

    hardware.enableRedistributableFirmware = true;
    hardware.firmware = [
      (pkgs.stdenv.mkDerivation {
       name = "broadcom-rpi3bplus-extra";
       src = pkgs.fetchurl {
         url = "https://raw.githubusercontent.com/RPi-Distro/firmware-nonfree/b518de4/brcm/brcmfmac43455-sdio.txt";
         sha256 = "0r4bvwkm3fx60bbpwd83zbjganjnffiq1jkaj0h20bwdj9ysawg9";
       };
       phases = [ "installPhase" ];
       installPhase = ''
         mkdir -p $out/lib/firmware/brcm
         cp $src $out/lib/firmware/brcm/brcmfmac43455-sdio.txt
       '';
       })
    ];

    boot.loader.generic-extlinux-compatible.configurationLimit = 1;

    services.mingetty.autologinUser = lib.mkForce null;

    networking.hostName = "raspberry";

    own = {
      ssh.enable = true;
      git.server = true;
      docker.enable = true;
      disable-docs = true;
      neovim = false;
    };

    swapDevices = [
      {
        device = "/var/swapfile";
        size = 1024;
      }
    ];

  };

}
