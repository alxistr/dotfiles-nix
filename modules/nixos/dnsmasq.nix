{ config, pkgs, lib, ... }:
let cfg = config.own; in
let docker = config.own.docker.enable; in
with lib; with types;
{
  options.own.dnsmasq = {
    enable = mkEnableOption "dnsmasq";
    adhosts = mkEnableOption "adhosts";
    extraConfig = mkOption {
      type = string;
      default = "";
    };
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
      '' + cfg.dnsmasq.extraConfig;
    };

    docker-containers = mkIf docker {
      docker-dns-gen = {
        image = "jderusse/dns-gen:latest";
        ports = [ "54:53/udp" ];
        volumes = [ "/var/run/docker.sock:/var/run/docker.sock" ];
      };
    };

  };

}
