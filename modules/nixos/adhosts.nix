{ config, pkgs, lib, ... }:
let cfg = config.own.adhosts; in
with lib; with types;
{
  options.own.adhosts = {
    enable = mkEnableOption "adhosts";
  };

  config = mkIf cfg.enable {
    networking.dhcpcd = {
      enable = true;
      extraConfig = ''
        supersede domain-name-servers 8.8.8.8, 8.8.4.4; 
      '';
    };

    services.dnsmasq = {
      enable = true;
      extraConfig = '' 
        # https://wiki.libvirt.org/page/Libvirtd_and_dnsmasq
        listen-address=127.0.0.1
        bind-interfaces

        # https://github.com/StevenBlack/hosts
        ${builtins.readFile pkgs.adhosts}

      '';
    };

  };

}
