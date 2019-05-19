{ config, pkgs, ... }:
{
  imports = [
    "${builtins.fetchTarball https://github.com/cleverca22/nixos-configs/tarball/76260ad60cd99d40ab25df1400b0663d48e736db}/qemu.nix"
    ./modules/generic
    ./modules/nixos
    ./host/configuration.nix
    ./host/hardware-configuration.nix
  ];

  system.stateVersion = "19.03";

}
