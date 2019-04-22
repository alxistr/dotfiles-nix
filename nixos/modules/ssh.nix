{ pkgs, config, lib, ... }:
let cfg = config.own.ssh; in
with lib; 
{
  options.own.ssh = {
    enable = mkOption { 
      default = false;
      type = types.bool; 
    };
    agent = mkOption { 
      default = false;
      type = types.bool; 
    }; 
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      passwordAuthentication = false;
      permitRootLogin = lib.mkForce "no"; 
      extraConfig = ''
        AllowUsers *@192.168.0.0/16
      '';
    };
    programs.mosh.enable = true;
    programs.ssh.startAgent = cfg.agent; 
  };

}
