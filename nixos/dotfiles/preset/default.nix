{ config, pkgs, lib, ... }:
let cfg = (import <nixpkgs/nixos> {}).config.own; in
let enable = cfg.gui.enable or cfg.sound.enable; in
with lib; with types;
{
  config = lib.mkIf enable {
    home.packages = with pkgs; [
      pasystray
      pavucontrol
      paprefs

      gparted
      gvfs

      cmus
      mpv

      qpdfview
      djview

      feh
      gthumb
      krita

      transmission-gtk

      appimage-run

    ];
  };

}
