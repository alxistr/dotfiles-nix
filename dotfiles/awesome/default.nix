{ config, pkgs, lib, ... }:
let cfg = config.nixos-config.own.gui; in
with lib; with types;
{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xfce4-14.thunar
      xfce4-14.thunar-volman
      scrot
      i3lockpp
      xcompmgr
      acpi
    ];

    xsession = {
      enable = true;
      initExtra = ''
        setxkbmap -layout us,ru -option 'grp:alt_shift_toggle,grp_led:scroll'
      '';
    };

    xsession.windowManager.awesome = {
      enable = true;
      luaModules = with pkgs; [
        awesome-freedesktop
      ];
    };

    home.file.".config/awesome/".source = ./awesome;

    programs.rofi = {
      enable = true;
      theme = "gruvbox-dark";
    };

    systemd.user.services.pasystray = {
      Unit = {
        Description = "pasystray";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.pasystray}/bin/pasystray";
        Restart = "always";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    systemd.user.services.xcompmgr = {
      Unit = {
        Description = "xcompmgr";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.xcompmgr}/bin/xcompmgr";
        Restart = "always";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

  };

}
