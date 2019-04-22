{ config, pkgs, lib, ... }:
let cfg = config.own; in
with lib; with types;
{
  options.own.disable-docs = mkEnableOption "docs";

  config = lib.mkIf cfg.disable-docs {
    documentation = {
      dev.enable = false;
      info.enable = false;
      man.enable = false;
      nixos.enable = false;
    };
  };

}
