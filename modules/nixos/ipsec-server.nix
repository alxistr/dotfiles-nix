{ config, pkgs, lib, ... }:

with lib; with types;

let
  ipsec-vpn = config.own.ipsec-vpn;
  xauth-lines = (mapAttrsToList
    (username: password: ''${username} : XAUTH "${password}" '')
    ipsec-vpn.users
  );
in

{
  options = {
    own.ipsec-vpn = {
      enable = mkOption {
        default = false;
        type = bool;
      };
      cidr = mkOption {
        type = str;
      };
      psk = mkOption {
        type = str;
      };
      users = mkOption {
        type = attrs;
        default = { };
      };
    };
  };

  config = mkIf ipsec-vpn.enable {
    networking.firewall = {
      allowedUDPPorts = [ 500 4500 ];
      extraCommands = ''
        iptables -t nat -A POSTROUTING -s ${ipsec-vpn.cidr} -o ens2 -j MASQUERADE
      '';
    };

    services.strongswan = {
      enable = true;
      secrets = [ "/run/keys/ipsec-vpn" ];
      connections = {
        "ipsec-vpn" = {
          ikelifetime = "60m";
          keylife = "20m";
          rekeymargin = "3m";
          keyingtries = "1";
          ike = "aes128-sha256-ecp256,aes256-sha384-ecp384,aes128-sha256-modp2048,aes128-sha1-modp2048,aes256-sha384-modp4096,aes256-sha256-modp4096,aes256-sha1-modp4096,aes128-sha256-modp1536,aes128-sha1-modp1536,aes256-sha384-modp2048,aes256-sha256-modp2048,aes256-sha1-modp2048,aes128-sha256-modp1024,aes128-sha1-modp1024,aes256-sha384-modp1536,aes256-sha256-modp1536,aes256-sha1-modp1536,aes256-sha384-modp1024,aes256-sha256-modp1024,aes256-sha1-modp1024!";
          esp = "aes128gcm16-ecp256,aes256gcm16-ecp384,aes128-sha256-ecp256,aes256-sha384-ecp384,aes128-sha256-modp2048,aes128-sha1-modp2048,aes256-sha384-modp4096,aes256-sha256-modp4096,aes256-sha1-modp4096,aes128-sha256-modp1536,aes128-sha1-modp1536,aes256-sha384-modp2048,aes256-sha256-modp2048,aes256-sha1-modp2048,aes128-sha256-modp1024,aes128-sha1-modp1024,aes256-sha384-modp1536,aes256-sha256-modp1536,aes256-sha1-modp1536,aes256-sha384-modp1024,aes256-sha256-modp1024,aes256-sha1-modp1024,aes128gcm16,aes256gcm16,aes128-sha256,aes128-sha1,aes256-sha384,aes256-sha256,aes256-sha1!";
          keyexchange = "ikev1";
          authby = "xauthpsk";
          xauth = "server";
          left = "%defaultroute";
          leftsubnet = "0.0.0.0/0";
          leftfirewall = "yes";
          right = "%any";
          rightsubnet = ipsec-vpn.cidr;
          rightsourceip = ipsec-vpn.cidr;
          rightdns = config.deployment.targetHost;
          auto = "add";
        };
      };
    };

    deployment.keys."ipsec-vpn" = {
      text = ''
        ${config.deployment.targetHost} %any : PSK "${ipsec-vpn.psk}"
      '' + (concatStringsSep "\n" xauth-lines);
    };

  };

}
