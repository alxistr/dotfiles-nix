{ config, pkgs, lib, ... }:
let cfg = config.own.log-activity; in
with lib; with types;
{
  options.own.log-activity = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      xact
    ];

    systemd.services.xact-logs = {
      requiredBy = [ "xact.service" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = ''
          mkdir -p /var/log/xactivity
          chown users:user /var/log/xactivity
        '';
      };
    };

    systemd.services.xact = {
      wantedBy = [ "multi-user.target" ];
      environment = {
        DISPLAY = ":0.0";
      };
      serviceConfig = {
        Type = "simple";
        User = "user";
        ExecStart = ''${pkgs.xact}/bin/xact.py'';
        Restart = "always";
        StandardOutput = "file:/var/log/xactivity/activity.log";
      };
    };

    services.logrotate.enable = true;
    services.logrotate.paths.xact = {
      path = "/var/log/xactivity/*.log";
      user = "user";
      group = "users";
      # keep = 100;
      frequency = "daily";
    };

  };

}
