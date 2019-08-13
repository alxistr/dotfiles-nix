{ config, pkgs, lib, ... }:

let cfg = config.own.docker; in
with lib; with types;

{
  options.own.docker = {
    enable = mkEnableOption "docker";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = (with pkgs; [
      docker
      docker-compose
      arion
      kind
      kubectl
    ]);

    virtualisation.docker.enable = true;

  };

}
