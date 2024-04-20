{ config, pkgs, lib, osConfig, ... }:
let cfg = osConfig.own.git; in
let enable = (cfg.server or cfg.name or cfg.email) != null; in
with lib; with types;
{
  config = {
    programs.git = {
      enable = enable;
      userName = cfg.name;
      userEmail = cfg.email;
      signing = mkIf (! isNull cfg.key) {
        key = cfg.key;
        signByDefault = true;
      };
      lfs.enable = true;

      extraConfig = {
        core = {
          autocrlf = "input";
          editor = "vim";
        };
        pull = {
          rebase = false;
        };
      };

      ignores = [
        ".idea/"
        ".python-version"
      ];

    };

  };
}
