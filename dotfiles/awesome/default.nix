{ config, pkgs, lib, osConfig, ... }:
let cfg = osConfig.own.gui; in
with lib; with types;
{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xfce.thunar
      xfce.thunar-volman
      scrot
      imagemagick
      i3lockpp
      xcompmgr
      acpi
      arandr
      awmtt
      xorg.xwininfo
    ];

    home.keyboard = null;

    xsession = {
      enable = true;
      # initExtra = ''
      #   setxkbmap -layout us,ru -option 'grp:alt_shift_toggle,grp_led:scroll'
      # '';
    };

    xsession.windowManager.awesome = {
      enable = true;
      luaModules = with pkgs; [
        awesome-freedesktop
        lua-moses
        (luaPackages.inspect)
      ];
    };

    home.file.".config/awesome/".source = "${pkgs.awesomerc.override {
      wallpaper = "${pkgs.wallpapers}/pattern0-light-.png";
      # wallpaper = "${pkgs.wallpapers}/pattern0.png";
    }}/lua";

    programs.rofi = {
      enable = true;
      theme = "gruvbox-light";
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
