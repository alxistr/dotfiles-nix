{ config, pkgs, lib, ... }:
let cfg = config.own.virtualisation; in
with lib; with types; 
{ 
  options.own.virtualisation = {
    enable = mkOption { 
      default = false;
      type = bool; 
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      qemu
      virtualbox
    ]; 
    virtualisation.libvirtd.enable = true;
  }; 

} 
