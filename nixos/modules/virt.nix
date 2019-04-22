{ config, pkgs, lib, ... }:
let cfg = config.own.virtualisation; in
with lib; 
{ 
  options.own.virtualisation = {
    enable = mkOption { 
      default = false;
      type = types.bool; 
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      qemu
      virtualbox
    ]; 
    virtualisation.libvirtd.enable = true;
  }; 

} 
