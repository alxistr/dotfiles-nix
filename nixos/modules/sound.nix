{ pkgs, config, lib, ... }:
let cfg = config.own.sound; in
with lib; 
{ 
  options.own.sound = {
    enable = mkOption { 
      default = false;
      type = types.bool; 
    };
  };

  config = lib.mkIf cfg.enable {
    sound.enable = true;
    hardware.pulseaudio.enable = true; 
  }; 

}
