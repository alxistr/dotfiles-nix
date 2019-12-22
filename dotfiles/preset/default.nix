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
      ffmpeg

      qpdfview
      djview
      masterpdfeditor

      feh
      gthumb
      krita

      transmission-gtk

      android-file-transfer

      scanmem

      sublime3
      jetbrains.pycharm-professional
      jetbrains.idea-ultimate

      youtube-dl
      bandcamp-downloader
      scdl

      appimage-run
      nixops
      fabric1
      apacheHttpd

      zoom-us

      # tor-browser-bundle-bin

      # pipenv
      # busybox
      leiningen
      visualvm
      joker
      exercism
      fennel
      love_11
      # nodejs-11_x

    ];

    home.file.".ideavimrc".source = ./ideavimrc;
    home.file.".config/mpv/input.conf".source = ./input.conf;

  };

}
