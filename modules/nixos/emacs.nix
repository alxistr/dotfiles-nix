{ pkgs, config, lib, ... }:
with lib; with types;
{
  options.own.emacs = {
    enable = mkOption {
      default = false;
      type = bool;
    };
  };
}
