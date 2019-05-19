{ config, pkgs, lib, ... }:
let secrets = config.own.secrets; 
    wirelessConfigured =  secrets.wireless != { }; in
with lib; with types; 
{ 
  config = mkIf wirelessConfigured { 
    networking.wireless.enable = true;
    networking.wireless.networks = secrets.wireless;
  }; 
} 
