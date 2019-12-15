{ config, lib, pkgs, ... }:
{
  imports = [
    ./modules/generic
    ./modules/nixos
    ./host/configuration.nix
    ./host/hardware-configuration.nix
  ] ++ lib.optional (builtins.pathExists ./local.nix) ./local.nix; 
}
