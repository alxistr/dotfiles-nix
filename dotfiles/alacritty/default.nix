{ config, pkgs, lib, ... }:

let cfg = config.nixos-config.own.gui; in
with lib; with types;

let
  theme = ./themes/gruvbox-light.yml;
  # theme = ./themes/gruvbox-dark.yml;
  font = {
    family = "Roboto Mono for Powerline";
    size = 10;
  };
  toYAML = lib.generators.toYAML { };
in

{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      alacritty
    ];

    home.file.".config/alacritty/alacritty.yml".text = toYAML {
      env = {
        TERM = "xterm-256color";
      };
      window = {
        padding = {
          x = 5;
          y = 5;
        };
      };
      scrolling = {
        history = 10000;
      };
      font = {
        normal.family = font.family;
        bold.family = font.family;
        italic.family = font.family;
        size = font.size;
      };
      dynamic_title = true;
      import = [
        theme
      ];
    };

  };

}
