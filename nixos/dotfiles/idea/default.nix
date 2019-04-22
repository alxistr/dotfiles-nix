{ config, pkgs, lib, ... }:
let cfg = (import <nixpkgs/nixos> {}).config.own.gui; in
with lib; with types;
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      jetbrains.pycharm-professional
      # jetbrains.idea-ultimate
    ];
    home.file.".ideavimrc".source = ./ideavimrc;
  };
}
