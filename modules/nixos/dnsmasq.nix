{ config, pkgs, lib, ... }:

let cfg = config.own.dnsmasq; in
let docker = config.own.docker; in
with lib; with types;

let
  adhosts-whitelist = pkgs.writeTextFile {
    name = "adhosts-whitelist";
    text = cfg.adhosts.whitelist;
  };
in

{
  options.own.dnsmasq = {
    enable = mkEnableOption "dnsmasq";
    extraConfig = mkOption {
      type = str;
      default = "";
    };
    adhosts = {
      enable = mkEnableOption "adhosts";
      whitelist = mkOption {
        default = ''
          binance.com
        '';
        type = lines;
      };
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
        '' + optionalString cfg.adhosts.enable ''
          conf-dir=/etc/dnsmasq.d
        '' + optionalString docker.enable ''
          server=/docker/127.0.0.1#54
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

    {
      system.activationScripts = {
        mkdnsmasqd = ''
          mkdir -p /etc/dnsmasq.d/
        '';
      };

      systemd = {
        paths.dnsmasqd-watcher = {
          pathConfig = {
            PathModified = "/etc/dnsmasq.d";
            Unit = "dnsmasq-reloader.service";
          };
          wantedBy = [ "adhosts-updater.service" ];
        };

        services.dnsmasq-reloader = {
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

    }

    (mkIf cfg.adhosts.enable {
      systemd = {
        services.adhosts-updater = {
          path = with pkgs; [ bash curl gawk ];
          script = ''
            echo "Update adhosts."
            filename=$(mktemp)
            curl -s -o - "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" |
            grep -Fv -f ${adhosts-whitelist} | \
            awk '/^0.0.0.0 / { printf "address=/%s/0.0.0.0\n", $2 }' > \
            $filename
            mv -f $filename adhosts.conf
          '';
          serviceConfig = {
            WorkingDirectory = "/etc/dnsmasq.d/";
          };
          wantedBy = [ "adhosts-updater.timer" ];
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
