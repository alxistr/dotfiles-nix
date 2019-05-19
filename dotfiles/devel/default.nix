{ config, pkgs, lib, ... }:
let enabled = config.nixos-config.own.gui.enable; in
with lib; with types;
{
  config = mkIf enabled {
    home.packages = with pkgs; [
      nixops
      # leiningen
      # rustup
      # luajit
      # love_11
    ];
  };
}
