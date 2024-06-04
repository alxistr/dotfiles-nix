{ config, pkgs, lib, osConfig, ... }:

let cfg = osConfig.own.gui; in
with lib; with types;

let
  theme = ./themes/gruvbox-light.toml;
  # theme = ./themes/gruvbox-dark.toml;
  font = {
    # family = "Roboto Mono for Powerline";
    # family = "Source Code Pro for Powerline";
    family = "APL386 Unicode";
    size = 10;
  };
in

{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      alacritty
    ];

    home.file.".config/alacritty/alacritty.toml".text = ''
      import = [
        "${theme}"
      ]

      [env]
      TERM = "xterm-256color"

      [font]
      size = ${toString(font.size)}

      [font.bold]
      family = "${font.family}"

      [font.italic]
      family = "${font.family}"

      [font.normal]
      family = "${font.family}"

      [scrolling]
      history = 10000

      [window.padding]
      x = 5
      y = 5
    '';

  };

}
