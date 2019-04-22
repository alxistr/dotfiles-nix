{ config, pkgs, lib, ... }:
let cfg = (import <nixpkgs/nixos> {}).config.own.gui; in
with lib; with types;
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      termite
    ];
    home.file.".config/termite/config".source = ./themes/gruvbox-dark-custom;
  };

}
