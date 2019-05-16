{ pkgs, ... }:
let shellAliases = import ./aliases.nix; in
{
  home.packages = with pkgs; [
    powerline-rs
    any-nix-shell
  ];

  programs.fish = {
    enable = true;
    shellInit = ''
      for f in ~/.config/fish/includes/*
        source $f
      end
      for f in ~/.config/fish/conf.d/*
        source $f
      end 
    '';
    inherit shellAliases;
  };
  home.file.".config/fish/includes".source = ./fish/functions;
  home.file.".config/fish/conf.d".source = ./fish/conf.d;

  # TODO: https://github.com/jethrokuan/fzf

}
