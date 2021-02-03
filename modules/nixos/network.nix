{ config, pkgs, lib, ... }:

let cfg = config.own; in
let wg = cfg.wireguard; in
with lib; with types;

{
  options.own = {
    wifi = mkOption {
      default = { };
      type = nullOr attrs;
    };
    ovpn = mkOption {
      default = { };
      type = attrs;
    };
    wireguard = {
      enable = mkOption { default = false; type = bool; };
      ip = mkOption { type = str; };
      privateKey = mkOption { type = str; };
      server = {
        host = mkOption { type = str; };
        port = mkOption { type = port; };
        publicKey = mkOption { type = str; };
      };
    };
  };

  config = mkMerge [
    {
      time.timeZone = mkDefault "Europe/Moscow";

      networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];

      networking.wireless = mkIf (cfg.wifi != { }) {
        enable = true;
        networks = cfg.wifi;
      };

      services.openvpn.servers = cfg.ovpn;

    }

    (mkIf wg.enable {
      networking.firewall.checkReversePath = false;

      networking.localCommands = ''
        ${pkgs.iproute}/bin/ip ro add default dev lo table 2468 metric 200
      '';

      networking.wireguard.interfaces = {
        wg0 = {
          ips = [ "${wg.ip}/32" ];
          privateKey = wg.privateKey;
          allowedIPsAsRoutes = false;
          peers = [
            {
              publicKey = wg.server.publicKey;
              allowedIPs = [ "0.0.0.0/0" ];
              endpoint = "${wg.server.host}:${toString wg.server.port}";
              persistentKeepalive = 25;
            }
          ];
          postSetup = ''
            wg set wg0 fwmark 1234
            ip route add default dev wg0 table 2468 metric 100
            ip rule add not fwmark 1234 table 2468
            ip rule add table main suppress_prefixlength 0
          '';
          postShutdown = ''
            ip route del default dev wg0 table 2468
            ip rule del not fwmark 1234 table 2468
            ip rule del table main suppress_prefixlength 0
          '';
        };
      };

    })
  ];

}
