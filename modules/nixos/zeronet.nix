{ config, pkgs, lib, ... }:

let cfg = config.own.zeronet; in
let container-name = "docker-zeronet.service"; in
with lib; with types;

{
  options.own.zeronet = {
    enable = mkEnableOption "zeronet";
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.own.docker.enable;
        message = "Enable docker first";
      }
    ];

    docker-containers = {
      zeronet = {
        image = "nofish/zeronet";
        log-driver = "journald";
        ports = [
          "127.0.0.1:43110:43110"
          # "127.0.0.1:9050:9050"
        ];
        environment = {
          ENABLE_TOR = "true";
        };
        volumes = [
          "/var/tmp/zeronet/:/root/data"
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      (pkgs.writeScriptBin "zeronet-logs" ''
        docker logs --follow --tail=100 ${container-name}
      '')
    ];

  };

}
