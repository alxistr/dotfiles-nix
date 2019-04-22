{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "laptop";
  networking.wireless.enable = true;
  networking.wireless.networks = config.own.secrets.wireless;

  own.ssh = {
    enable = true;
    agent = true;
  };
  own.sound.enable = true;
  own.gui.enable = true;
  own.docker.enable = true;
  own.virtualisation.enable = true;

}
