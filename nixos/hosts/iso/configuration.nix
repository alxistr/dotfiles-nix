{ config, pkgs, ... }:
{
  networking.hostName = "iso";
  networking.wireless.enable = true;
  networking.wireless.networks = config.own.secrets.wireless;

  own.ssh = {
    enable = true;
  };
  own.sound.enable = true;
  own.gui.enable = true;
  own.docker.enable = true;
  own.virtualisation.enable = true;

}
