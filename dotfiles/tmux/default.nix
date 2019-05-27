{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tmux
    tmuxp
  ];

  home.file.".tmux.conf".source = ./tmux.conf;

}
