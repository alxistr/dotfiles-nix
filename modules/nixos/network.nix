{ config, pkgs, lib, ... }:
let secrets = config.own.secrets; 
    wirelessConfigured =  secrets.wireless != { }; in
with lib; with types; 
{ 
  config = { 
    networking.hosts = secrets.hosts; 
    networking.wireless = mkIf wirelessConfigured {
      enable = true;
      networks = secrets.wireless; 
    }; 
  }; 
} 
