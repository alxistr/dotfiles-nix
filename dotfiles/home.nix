{ config, pkgs, ... }:
{
  imports = [
    ../modules/generic
    ../modules/home
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

  programs.home-manager.enable = true;

}
