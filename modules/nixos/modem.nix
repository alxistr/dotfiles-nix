{ config, pkgs, lib, ... }:
let cfg = config.own.modem; in
with lib; with types;
{
  options.own.modem = {
    enabled = mkOption {
      default = false;
      type = bool;
    };
  };

  config = mkIf cfg.enabled {
    environment.systemPackages = (with pkgs; [
      usb-modeswitch
      dhcp
      (pkgs.writeScriptBin "switch-e3372" ''
        usb_modeswitch -J -v 0x12d1 -p 0x1f01
      '')
    ]);
  };

}

