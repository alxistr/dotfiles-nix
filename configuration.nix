{ config, lib, pkgs, ... }:
{
  imports = [
    ./modules/generic
    ./modules/nixos
    ./host/configuration.nix
    ./host/hardware-configuration.nix
  ] ++ lib.optional (builtins.pathExists ./local.nix) ./local.nix;
  # nix.settings.substituters = [
  #   "https://aseipp-nix-cache.global.ssl.fastly.net"
  #   "https://aseipp-nix-cache.freetls.fastly.net"
  # ];
  system.stateVersion = "19.03";
}
