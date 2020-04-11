{ config, pkgs, lib, ... }:
let cfg = config.own.git; in
with lib; with types;
{
  options.own.git = {
    server = mkOption {
      default = false;
      type = bool;
    };
    name = mkOption {
      default = null;
      type = nullOr str;
    };
    email = mkOption {
      default = null;
      type = nullOr str;
    };
    key = mkOption {
      default = null;
      type = nullOr str;
    };
    repos = mkOption {
      default = [ ];
      type = listOf str;
    };
  };

  config = mkIf cfg.server {
    users.users.git = with pkgs; {
      isNormalUser = true;
      createHome = true;
      shell = "${pkgs.git}/bin/git-shell";
      openssh.authorizedKeys.keys = config.own.ssh.authorized-keys;
    };

    system.activationScripts = listToAttrs (map (name: assert name != ""; {
      name = "check-git-repo-${name}";
      value = ''
        (
          mkdir -p /home/git/repos/
          cd /home/git/repos/
          if [[ ! -d ${name}.git ]]; then
            ${pkgs.git}/bin/git init --bare ${name}.git
            chown -R git ${name}.git
          fi
        )
      '';
    }) cfg.repos);

  };

}
