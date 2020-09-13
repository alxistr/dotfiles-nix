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
      #(fbreader.override { uiType = "gtk"; })
      fbreader

      xnview
      feh
      # gthumb
      krita
      # aseprite-unfree

      transmission-gtk

      # android-file-transfer
      go-mtpfs

      wxhexeditor
      scanmem

      sublime3
      jetbrains.pycharm-professional
      jetbrains.idea-ultimate

      youtube-dl
      # bandcamp-downloader
      scdl

      appimage-run
      apacheHttpd

      zoom-us
      discord

      # tor-browser-bundle-bin

      nixops
      fabric1
      scaleway-cli
      dysnomia
      disnix

      openjdk11
      leiningen
      clojure
      visualvm

      fennel
      ferret
      babashka
      chez

      erlang
      gprolog

      love_11
      # exercism

      ## signal analysis
      # mpg123
      # baudline
      audacity

    ];

    home.file.".ideavimrc".source = ./ideavimrc;
    home.file.".config/mpv/input.conf".source = ./mpv-input.conf;

  };

}
