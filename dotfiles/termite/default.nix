{ config, pkgs, lib, ... }:

let cfg = config.nixos-config.own.gui; in
with lib; with types;

# let default-theme = "gruvbox-dark-custom"; in
let default-theme = "gruvbox-light"; in

{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      termite
      (pkgs.writeScriptBin "switch-termite-theme"
        ''
          theme=''${1:-${default-theme}}
          filename=${./themes}/$theme
          if [[ ! -f "$filename" ]]; then
            echo "theme $filename doesn't exist"
            return 1
          fi
          mkdir -p ~/.config/termite
          ln -sf $filename ~/.config/termite/config
          pkill -SIGUSR1 termite
        '')
    ];

    home.activation.initial-termite-theme = ''
      [[ -f "~/.config/termite/config" ]] || switch-termite-theme || true
    '';

  };

}
