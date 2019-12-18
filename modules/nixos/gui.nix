{ config, pkgs, lib, ... }:
let cfg = config.own.gui; in
with lib; with types;
{
  options.own.gui = {
    enable = mkEnableOption "";
    nvidia = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    sound.enable = true;
    hardware.pulseaudio.enable = true;

    i18n = {
      consoleFont = "cyr-sun16";
      consoleKeyMap = "ru";
      defaultLocale = "en_US.UTF-8";
    };

    environment.systemPackages = with pkgs; [
      fontconfig
    ];

    fonts.enableFontDir = true;
    fonts.enableGhostscriptFonts = true;
    fonts.fonts = with pkgs; [
      anonymousPro
      dejavu_fonts
      freefont_ttf
      liberation_ttf
      source-code-pro
      terminus_font
      font-awesome_5
      powerline-fonts
    ];

    services.dbus.packages = with pkgs; [ gnome3.dconf ];

    hardware.nvidia = mkIf cfg.nvidia {
      modesetting.enable = true;
      optimus_prime = {
        enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    services.xserver = {
      enable = true;
      videoDrivers = mkIf cfg.nvidia [ "nvidia" ];
      libinput.enable = true;
      layout = "us,ru";
      xkbOptions = "grp:alt_shift_toggle,grp_led:scroll";
      xkbVariant = "qwerty";
      gdk-pixbuf.modulePackages = with pkgs; [ librsvg ];
      displayManager.lightdm = {
        enable = true;
        background = "#000000";
      };
    };

  };

}
