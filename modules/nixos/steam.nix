{ config, pkgs, lib, ... }:
let cfg = config.own.steam; in
with lib; with types;
{
  options.own.steam = {
    enable = mkOption {
      default = false;
      type = bool;
    };
  };

  config = lib.mkIf cfg.enable { 
    environment.systemPackages = with pkgs; [
      steam
    ];

    hardware.opengl.driSupport32Bit = true;
    hardware.pulseaudio.support32Bit = true;
    hardware.steam-hardware.enable = true;

  };

}
