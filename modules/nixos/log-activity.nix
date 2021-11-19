{ config, pkgs, lib, ... }:
let cfg = config.own.log-activity; in
with lib; with types;
{
  options.own.log-activity = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    systemd.services.xact-logs = {
      requiredBy = [ "xact.service" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "create-paths" ''
          ${pkgs.coreutils}/bin/mkdir -p /var/log/xactivity
          ${pkgs.coreutils}/bin/touch /var/log/xactivity/activity.log
          ${pkgs.coreutils}/bin/chown user:users \
            /var/log/xactivity \
            /var/log/xactivity/activity.log
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
        Group = "users";
        ExecStart = ''${pkgs.xact}/bin/xact.py'';
        Restart = "always";
        StandardOutput = "file:/var/log/xactivity/activity.log";
        StandardError = "journal";
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
