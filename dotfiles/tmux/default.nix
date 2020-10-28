{ pkgs, ... }:

# let default-theme = "dark"; in
let default-theme = "light"; in

{
  home.packages = with pkgs; [
    tmux
    tmuxp
    (pkgs.writeScriptBin "switch-tmux-theme"
      ''
        theme=''${1:-${default-theme}}
        filename=${./themes}/tmux-$theme.conf
        if [[ ! -f "$filename" ]]; then
          echo "theme $filename doesn't exist"
          return 1
        fi
        ln -sf $filename ~/.tmux.conf
        tmux source-file ~/.tmux.conf
      '')
  ];

  # home.file.".tmux.conf".source = ./tmux-light.conf;
  # home.file.".tmux.conf".source = ./tmux-dark.conf;

  home.activation.initial-tmux-theme = ''
    [[ -f "~/.tmux.conf" ]] || switch-tmux-theme || true
  '';

}
