{ pkgs, config, lib, ... }:

let cfg = config.own.ssh; in
with lib; with types;

let buildKey = pkgs.runCommand "build-key" { } ''
  ${pkgs.openssh}/bin/ssh-keygen -t rsa -N "" -f $out
''; in

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
    initrd = mkOption {
      default = false;
      type = bool;
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      services.openssh = {
        enable = true;
        ports = [ 22 ];
        passwordAuthentication = false;
        permitRootLogin = mkForce "no";
        extraConfig = ''
          AllowUsers *@127.0.0.0/8
          AllowUsers *@192.168.0.0/16
        '';
      };
      programs.mosh.enable = true;
      programs.ssh.startAgent = cfg.agent;

      boot.initrd = mkIf cfg.initrd {
        availableKernelModules = [ "r8169" ];
        network = {
          enable = true;
          ssh = {
            enable = true;
            port = 2222;
            authorizedKeys = cfg.authorized-keys;
            hostKeys = [
              ( buildKey )
            ];
            extraConfig = ''
              AllowUsers *@192.168.0.0/16
            '';
          };
          udhcpc.extraArgs = [ "-t 30" "-A 1" ];
        };
      };
    })

    (mkIf (cfg.matchs != { }) {
      home-manager.users."user".programs.ssh = ({
        enable = true;
        matchBlocks = cfg.matchs;
      });
    })

  ];

}
