{ config, pkgs, lib, ... }:
let enabled = config.nixos-config.own.gui.enable; in
with lib; with types;
{
  config = mkIf enabled {
    home.packages = with pkgs; [
      termite
    ];
    home.file.".config/termite/config".source = ./themes/gruvbox-dark-custom;
  };

}
