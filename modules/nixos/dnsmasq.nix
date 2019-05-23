{ config, pkgs, lib, ... }:
let cfg = config.own; in
let docker = config.own.docker.enable; in
with lib; with types;
{
  options.own.dnsmasq = {
    enable = mkEnableOption "dnsmasq";
    adhosts = mkEnableOption "adhosts";
  };

  config = mkIf cfg.dnsmasq.enable {
    networking.dhcpcd = {
      enable = true;
    };

    services.dnsmasq = {
      enable = true;
      extraConfig = '' 
        # https://wiki.libvirt.org/page/Libvirtd_and_dnsmasq
        listen-address=127.0.0.1
        bind-interfaces 
      '' + optionalString cfg.docker.enable ''
        server=/docker/127.0.0.1#54 
      '' + optionalString cfg.dnsmasq.adhosts ''
        # https://github.com/StevenBlack/hosts
        ${builtins.readFile pkgs.adhosts} 
      '';
    };

    # https://github.com/benley/nixpkgs/blob/258d05d543fb03c6785da46b6893de14ced84266/nixos/modules/virtualisation/docker-containers.nix
    systemd.services.docker-dns-gen = mkIf cfg.docker.enable {
      after = [ "docker.service" "docker.socket" ];
      requires = [ "docker.service" "docker.socket" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = concatStringsSep " \\\n" ([
          "${pkgs.docker}/bin/docker run"
          "--rm"
          "--name=%n" 
          "-p 54:53/udp" 
          "-v /var/run/docker.sock:/var/run/docker.sock"
          "jderusse/dns-gen:latest"
        ]);
        ExecStartPre = "-${pkgs.docker}/bin/docker rm -f %n";
        ExecStop = "${pkgs.docker}/bin/docker stop %n";
        ExecStopPost = "-${pkgs.docker}/bin/docker rm -f %n"; 
        TimeoutStartSec = 0;
        TimeoutStopSec = 120;
        Restart = "always";
      };
    };

  };

}
