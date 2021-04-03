{ config, pkgs, lib, ... }:

let cfg = config.own; in
let wg = cfg.wireguard; in
with lib; with types;

let table = "2468"; in

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

    {
      boot.kernel.sysctl = {
        "net.ipv6.conf.default.disable_ipv6" = 1;
        "net.ipv6.conf.lo.disable_ipv6" = 1;
      };
    }

    (mkIf wg.enable {
      networking.firewall.checkReversePath = false;

      networking.localCommands = ''
        set +e
        ${pkgs.iproute}/bin/ip ro list table ${table} | grep -q "default dev lo"
        if [ $? -eq 1 ]; then
          ${pkgs.iproute}/bin/ip ro add default dev lo metric 200 table ${table}
        fi || true
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
            ip route add default dev wg0 table ${table} metric 100
            ip rule add not fwmark 1234 table ${table}
            ip rule add table main suppress_prefixlength 0
          '';
          postShutdown = ''
            ip route del default dev wg0 table ${table}
            ip rule del not fwmark 1234 table ${table}
            ip rule del table main suppress_prefixlength 0
          '';
        };
      };

    })
  ];

}
