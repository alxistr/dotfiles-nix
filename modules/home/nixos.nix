{ pkgs, config, lib, ... }:
let cfg = (import <nixpkgs/nixos> {}).config; in 
with lib; with types;
{
  options.nixos-config = mkOption {
    default = { };
    type = attrs;
  };

  config = {
    nixos-config = cfg;
  };

}
