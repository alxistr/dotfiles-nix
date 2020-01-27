{ config, pkgs, lib, ... }:

let cfg = config.own.mail; in
with lib; with types;

{
  options.own.mail = {
    enable = mkEnableOption "mail setup";
    gmail = mkOption {
      type = listOf str;
      default = [];
    };
    airmail = mkOption {
      type = listOf str;
      default = [];
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."user" = import ../../dotfiles/mail;
  };

}
