{ config, pkgs, lib, ... }:

let cfg = config.own.tor; in
let container-name = "tor"; in
with lib; with types;

{
  options.own.tor = {
    enable = mkEnableOption "tor";
    country = mkOption {
      type = nullOr str;
      default = null;
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.own.docker.enable;
        message = "Enable docker first";
      }
    ];

    virtualisation.oci-containers.containers = {
      tor = {
        image = "dperson/torproxy:latest";
        log-driver = "journald";
        ports = [
          "127.0.0.1:8118:8118"
          "127.0.0.1:9050:9050"
        ];
        environment = {
          TZ = "UTC";
        };
        cmd = mkIf (cfg.country != null) [ "-l" cfg.country ];
      };
    };

    systemd.services.docker-tor.serviceConfig.TimeoutStopSec = lib.mkForce 1;

    environment.systemPackages = with pkgs; [
      (pkgs.writeScriptBin "tor-logs" ''
        docker logs --follow --tail=100 ${container-name}
      '')

      (pkgs.writeScriptBin "tor-new-circuits" ''
        docker exec -it ${container-name} torproxy.sh -n
      '')

    ];

  };

}
