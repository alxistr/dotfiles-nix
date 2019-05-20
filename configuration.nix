{ config, lib, pkgs, ... }:
let nixos-configs = builtins.fetchGit {
  url = "https://github.com/cleverca22/nixos-configs.git";
  rev = "76260ad60cd99d40ab25df1400b0663d48e736db";
}; in
{
  imports = [
    "${nixos-configs}/qemu.nix"
    ./modules/generic
    ./modules/nixos
    ./host/configuration.nix
    ./host/hardware-configuration.nix
  ] ++ lib.optional (builtins.pathExists ./secrets.nix) ./secrets.nix;

  system.stateVersion = "19.03";

}
