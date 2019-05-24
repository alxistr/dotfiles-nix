{ config, pkgs, lib, ... }:
let cfg = config.own; in
with lib; with types;
{
  options.own = {
    wifi = mkOption {
      default = { };
      type = nullOr attrs;
    };
    vpn = mkOption {
      default = { };
      type = attrs;
    };
  };

  config = {
    time.timeZone = mkDefault "Europe/Moscow";

    networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];

    networking.wireless = mkIf (cfg.wifi != { }) {
      enable = true;
      networks = cfg.wifi;
      interfaces = [ "wlan0" ];
    };

    services.openvpn.servers = cfg.vpn;

  };

}
