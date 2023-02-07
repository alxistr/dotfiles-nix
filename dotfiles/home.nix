{ config, pkgs, ... }:
{
  imports = [
    ../modules/generic
    ../modules/home
    ./alacritty
    ./awesome
    ./browsers
    ./emacs
    ./git
    ./network
    ./preset
    ./ranger
    ./shell
    ./termite
    ./themes
    ./tmux
    ./vim
  ];

  home.stateVersion = "19.03";
  programs.home-manager.enable = true;

}
