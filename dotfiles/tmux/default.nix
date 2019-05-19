{ pkgs, ... }: 
{ 
  home.packages = [ pkgs.tmux ];

  home.file.".tmux.conf".source = ./tmux.conf; 

}
