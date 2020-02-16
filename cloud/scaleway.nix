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

      allowTTY = false;

      wireguard = with secrets.wireguard; {
        enable = true;
        cidr = "192.168.144.0/24";
        server = "192.168.144.1/32";
        private-key = server.private;
        clients = [
          (wg-peer "192.168.144.2" nettop.public)
          (wg-peer "192.168.144.3" laptop.public)
          (wg-peer "192.168.144.4" desktop.public)
          (wg-peer "192.168.144.5" rpi.public)
          (wg-peer "192.168.144.6" android.public)
        ];
      };

      ipsec-vpn = with secrets.ipsec; {
        enable = true;
        cidr = "192.168.145.0/24";
        inherit psk users;
      };

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
