{ pkgs, config, lib, ... }:
with lib; with types;
{
  options.own.emacs = mkOption {
    type = bool;
    default = false;
  };
}
