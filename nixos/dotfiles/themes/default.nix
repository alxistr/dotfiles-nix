{ config, pkgs, lib, ... }:
let cfg = (import <nixpkgs/nixos> {}).config.own.gui; in
with lib; with types;
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      lxappearance
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
        package = with pkgs; stdenv.mkDerivation rec {
          name = "Flat-Remix";
          pname = "Flat-Remix";
          src = fetchTarball "https://github.com/daniruiz/flat-remix/archive/20190427.tar.gz";
          nativeBuildInputs = [ gtk3 ];
          installPhase = ''
            mkdir -p $out/share/icons
            mv Flat-Remix* $out/share/icons/
          '';
          postFixup = ''
            for theme in $out/share/icons/*; do
              gtk-update-icon-cache $theme
            done
          '';
        };
      };

    };

  };

}
