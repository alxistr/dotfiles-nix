{ config, pkgs, lib, ... }:

let enabled = config.nixos-config.own.gui.enable; in
with lib; with types;

let default-theme = "dark"; in
# let default-theme = "light"; in

{
  config = mkIf enabled {
    home.packages = with pkgs; [
      lxappearance
      (pkgs.writeScriptBin "switch-xresources"
        ''
          theme=''${1:-${default-theme}}
          filename=${./xresources}/gruvbox-$theme.xresources
          if [[ ! -f "$filename" ]]; then
            echo "theme $filename doesn't exist"
            return 1
          fi
          ln -sf $filename ~/.xresources
          xrdb $filename
        '')
    ];

    gtk = {
      enable = true;

      font = {
        name = "DejaVu Sans 10";
        package = pkgs.dejavu_fonts;
      };

      gtk3 = {
        extraCss = ''
          VteTerminal, vte-terminal {
              padding: 5px;
          }
        '';
      };

      theme = {
        name = "Arc-Dark";
        package = pkgs.arc-theme;
      };

      iconTheme = {
        name = "Flat-Remix-Blue-Dark";
        package = pkgs.flat-remix;
      };

    };

    qt = {
      enable = true;
      platformTheme = "gtk";
    };

    home.activation.initial-xresources = ''
      [[ -f "~/.xresources" ]] || switch-xresources || true
    '';

  };

}
