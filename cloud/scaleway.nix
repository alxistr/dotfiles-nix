let
  secrets = import ./../secrets.nix;

  vps = { host, port ? 22 }: { config, pkgs, lib, ... }: {
    imports = [
      ./../modules/nixos/dnsmasq.nix
      ./../modules/nixos/scaleway.nix
      ./../modules/nixos/ipsec-server.nix
      ./../modules/nixos/wireguard-server.nix
    ];

    deployment.targetHost = host;

    own = {
      scaleway = true;

      f2b-whitelist = secrets.f2b-whitelist;

      allowTTY = false;

      wireguard = {
        enable = true;
      } // secrets.wireguard-server;

      ipsec-vpn = {
        enable = true;
      } // secrets.ipsec-server;

      dnsmasq = {
        enable = true;
        listen = lib.mkForce [ ];
        bind-interfaces = false;
        adhosts.enable = true;
      };

    };

  };

in

{
  vpn5 = vps secrets.servers.vpn5;
}
