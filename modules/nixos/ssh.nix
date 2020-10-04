{ pkgs, config, lib, ... }:
let cfg = config.own.ssh; in
with lib; with types;
{
  options.own.ssh = {
    enable = mkOption {
      default = false;
      type = bool;
    };
    agent = mkOption {
      default = false;
      type = bool;
    };
    authorized-keys = mkOption {
      default = [ ];
      type = listOf str;
    };
    matchs = mkOption {
      default = { };
      type = attrs;
    };
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      passwordAuthentication = false;
      permitRootLogin = mkForce "no";
      extraConfig = ''
        AllowUsers *@192.168.0.0/16
      '';
    };
    programs.mosh.enable = true;
    programs.ssh.startAgent = cfg.agent;

    home-manager.users."user".programs.ssh = (mkIf (cfg.matchs != { }) {
      enable = true;
      matchBlocks = cfg.matchs;
    });

  };

}
