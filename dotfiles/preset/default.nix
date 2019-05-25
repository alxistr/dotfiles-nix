{ config, pkgs, lib, ... }:
let cfg = config.nixos-config.own.gui; in
with lib; with types;
{
  config = mkIf cfg.enable {
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

      sublime3
      jetbrains.pycharm-professional
      # jetbrains.idea-ultimate

      youtube-dl
      bandcamp-downloader
      scdl

      appimage-run
      nixops
      fabric1

    ];

    home.file.".ideavimrc".source = ./ideavimrc;

  };

}
