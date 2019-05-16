{ config, pkgs, ... }:
{ 
  networking.hostName = "raspberry";
  networking.wireless.enable = true;
  networking.wireless.networks = config.own.secrets.wireless;

  own.ssh = {
    enable = true;
  };
  own.docker.enable = true; 
  own.disable-docs = true;

}
