{ config, pkgs, lib, ... }:
let cfg = config.nixos-config.own.gui; in
with lib; with types;
{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      termite
    ];
    home.file.".config/termite/config".source = ./themes/gruvbox-dark-custom;
  };

}
