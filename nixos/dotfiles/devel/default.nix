{ config, pkgs, lib, ... }:
let cfg = (import <nixpkgs/nixos> {}).config.own.gui; in
with lib; with types;
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nixops
      # leiningen
      # rustup
      # luajit
      # love_11
    ];
  };
}
