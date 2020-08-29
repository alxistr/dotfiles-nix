{ config, pkgs, lib, ... }:

let enable = config.nixos-config.own.neovim; in
with lib; with types;

{
  config = mkIf enable {
    home.packages = with pkgs; [
      ag
      fzf
      my-neovim
    ];
  };
}
