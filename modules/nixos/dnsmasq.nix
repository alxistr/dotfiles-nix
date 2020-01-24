{ config, pkgs, lib, ... }:

let cfg = config.own.dnsmasq; in
let docker = config.own.docker; in
with lib; with types;

let 
  adhosts-whitelist = pkgs.writeTextFile {
    name = "adhosts-whitelist";
    text = ''
      binance.com
    ''; 
  };
  adhosts-url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
in

{
  options.own.dnsmasq = {
    enable = mkEnableOption "dnsmasq";
    adhosts = mkEnableOption "adhosts";
    extraConfig = mkOption {
      type = string;
      default = "";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      networking.dhcpcd = {
        enable = true;
      };

      services.dnsmasq = {
        enable = true;
        extraConfig = ''
          # https://wiki.libvirt.org/page/Libvirtd_and_dnsmasq
          listen-address=127.0.0.1
          bind-interfaces
        '' + optionalString docker.enable ''
          server=/docker/127.0.0.1#54
        '' + optionalString cfg.adhosts ''
          conf-dir=/etc/dnsmasq.d
        '' + cfg.extraConfig;
      };

      docker-containers = mkIf docker.enable {
        dns-gen = {
          image = "jderusse/dns-gen:latest";
          ports = [ "54:53/udp" ];
          volumes = [ "/var/run/docker.sock:/var/run/docker.sock" ];
          log-driver = "journald";
        };
      };
    }

    (mkIf cfg.adhosts { 
      system.activationScripts = {
        mkdnsmasqd = ''
          mkdir -p /etc/dnsmasq.d/ 
        '';
      };

      systemd = { 
        services = { 
          adhosts-updater = {
            path = with pkgs; [ bash curl gawk ];
            script = ''
              echo "Update adhosts."
              curl -s -o - "${adhosts-url}" |
              grep -Fv -f ${adhosts-whitelist} | \
              awk '/^0.0.0.0 / { printf "address=/%s/0.0.0.0\n", $2 }' > \
              adhosts.conf
            '';
            serviceConfig = {
              WorkingDirectory = "/etc/dnsmasq.d/";
            };
            wantedBy = [ "adhosts-updater.timer" ];
          };

          dnsmasq-reloader = {
            script = ''
              echo "/etc/dnsmasq.d changed. Reload dnsmasq."
              systemctl restart dnsmasq 
            '';
            serviceConfig = {
              Type = "oneshot"; 
            };
            wantedBy = [ "adhosts-updater.timer" ];
          };

        };

        paths.dnsmasqd-watcher = {
          pathConfig = {
            PathModified = "/etc/dnsmasq.d";
            Unit = "dnsmasq-reloader.service";
          };
          wantedBy = [ "adhosts-updater.service" ];
        };

        timers.adhosts-updater = {
          timerConfig = {
            Unit = "adhosts-updater.service";
            OnCalendar = "06:00";
          };
          wantedBy = [ "timers.target" ];
        };

      };
    
    })
  
  ]);

}
