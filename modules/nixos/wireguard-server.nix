{ config, pkgs, lib, ... }:

with lib; with types;

let wg-config = config.own.wireguard; in

{
  options = {
    own.wireguard = {
      enable = mkOption {
        default = false;
        type = bool;
      };
      port = mkOption {
        default = 44881;
        type = port;
      };
      server = mkOption {
        type = str;
      };
      cidr = mkOption {
        type = str;
      };
      private-key = mkOption {
        type = str;
      };
      ext = mkOption {
        type = str;
        default = "ens2";
      };
      clients = mkOption {
        default = [ ];
        type = listOf (submodule {
          options = {
            publicKey = mkOption { type = str; };
            allowedIPs = mkOption { type = listOf str; };
          };
        });
      };
    };
  };

  config = mkIf wg-config.enable {
    boot.kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv4.conf.all.proxy_arp" = 1;
    };

    networking.nat = {
      enable = true;
      externalInterface = wg-config.ext;  # todo: iface
      internalInterfaces = [ "wg0" ];
      internalIPs = [ wg-config.cidr ];
    };

    networking.firewall = {
      allowedUDPPorts = [ wg-config.port ];
    };

    networking.wireguard = {
      enable = true;
      interfaces = {
        wg0 = {
          ips = [ wg-config.server ];
          listenPort = wg-config.port;
          privateKeyFile = "/run/keys/wg-privatekey";
          peers = wg-config.clients;
        };
      };
    };

    deployment.keys.wg-privatekey = {
      text = wg-config.private-key;
    };

  };

}
