{ pkgs, config, lib, ... }:
with lib; with types;
{
  options.own.neovim = mkOption {
    type = bool;
    default = true;
  };
}
