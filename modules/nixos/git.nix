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
      type = nullOr string;
    };
    email = mkOption {
      default = null;
      type = nullOr string;
    };
    key = mkOption {
      default = null;
      type = nullOr string;
    };
  };

  config = mkIf cfg.server {
    users.users.git = with pkgs; {
      isNormalUser = true;
      createHome = true;
      shell = "${pkgs.git}/bin/git-shell";
      openssh.authorizedKeys.keys = config.own.ssh.authorized-keys;
    };
  };

}
