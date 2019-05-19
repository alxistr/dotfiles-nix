{ config, pkgs, ... }:
{
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "raspberry";
  networking.wireless.enable = true;
  networking.wireless.networks = config.own.secrets.wireless;

  own.ssh = {
    enable = true;
  };
  own.docker.enable = true; 
  own.disable-docs = true;

}
