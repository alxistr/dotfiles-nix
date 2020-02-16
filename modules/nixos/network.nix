{ config, pkgs, lib, ... }:

let cfg = config.own; in
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

  config = {
    time.timeZone = mkDefault "Europe/Moscow";

    networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];

    networking.wireless = mkIf (cfg.wifi != { }) {
      enable = true;
      networks = cfg.wifi;
    };

    services.openvpn.servers = cfg.ovpn;

    networking.wireguard.interfaces = with cfg.wireguard; mkIf (enable) {
      wg0 = {
        ips = [ "${ip}/32" ];
        inherit privateKey;
        allowedIPsAsRoutes = false;
        peers = [
          {
            publicKey = server.publicKey;
            allowedIPs = [ "0.0.0.0/0" ];
            endpoint = "${server.host}:${toString server.port}";
            persistentKeepalive = 25;
          }
        ];
        postSetup = ''
          default_gateway=$(ip route | ${pkgs.gawk}/bin/awk '/default/ { print $3 }')
          ip ro add 0.0.0.0/1 via ${ip} dev wg0
          ip ro add 128.0.0.0/1 via ${ip} dev wg0
          ip ro add ${server.host} via $default_gateway
          ip ro flush cache
        '';
        postShutdown = ''
          ip ro del ${server.host}
        '';
      };
    };

  };

}
