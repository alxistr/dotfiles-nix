{ config, pkgs, lib, ... }:
let secrets = config.own.secrets; in
with lib; with types; 
{ 
  config = { 
    services.openvpn.servers = secrets.vpn;
  }; 
} 
