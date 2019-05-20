{ config, pkgs, lib, ... }:
let cfg = config.own; in
with lib; with types; 
{
  options.own.disable-docs = mkEnableOption "docs";

  config = lib.mkIf cfg.disable-docs {
    documentation = {
      dev.enable = mkForce false;
      info.enable = mkForce false;
      man.enable = mkForce false;
      nixos.enable = mkOverride 10 false;
    };
    services.nixosManual.showManual = mkOverride 10 false; 
  };

}
