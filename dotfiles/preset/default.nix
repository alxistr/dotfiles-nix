{ config, pkgs, lib, ... }:
let own = config.nixos-config.own;
    enabled = own.gui.enable; in
with lib; with types;
{
  config = mkIf enabled {
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

      appimage-run 
      nixops
      Fabric

    ];

    home.file.".ideavimrc".source = ./ideavimrc;

  };

}
