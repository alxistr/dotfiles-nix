{ config, lib, pkgs, ... }:
{
  imports = [
    ./modules/generic
    ./modules/nixos
    ./host/configuration.nix
    ./host/hardware-configuration.nix
  ] ++ lib.optional (builtins.pathExists ./secrets.nix) ./secrets.nix;

  system.stateVersion = "19.03";

}
