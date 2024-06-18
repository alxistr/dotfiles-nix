{ config, pkgs, lib, ... }:
let cfg = config.own.gui; in
with lib; with types;
{
  options.own.gui = {
    enable = mkEnableOption "";
    heavy = mkOption {
      default = true;
      type = bool;
    };
    nvidia = mkEnableOption "";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      sound.enable = true;
      environment.systemPackages = with pkgs; [
        pasystray
        pavucontrol
        paprefs
        qjackctl
        helvum
      ];

      services.pipewire = {
        enable = true;
        audio.enable = true;
        systemWide = true;
        pulse.enable = true;
        jack.enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        wireplumber.enable = true;
      };

    }

    {
      console = {
        font = "cyr-sun16";
        keyMap = "ru";
      };

      i18n = {
        defaultLocale = "en_US.UTF-8";
      };

      environment.systemPackages = with pkgs; [
        fontconfig
      ];

      fonts.fontDir.enable = true;
      # fonts.enableFontDir = true;
      fonts.enableGhostscriptFonts = true;
      fonts.packages = with pkgs; [
        anonymousPro
        dejavu_fonts
        freefont_ttf
        liberation_ttf
        source-code-pro
        terminus_font
        font-awesome_5
        powerline-fonts
        apl386
      ];

      services.dbus.packages = with pkgs; [ dconf ];
      programs.dconf.enable = true;

      hardware.nvidia = mkIf cfg.nvidia {
        modesetting.enable = true;
        prime = {
          sync.enable = true;
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };

      services.libinput.enable = true;

      services.xserver = {
        enable = true;
        videoDrivers = mkIf cfg.nvidia [ "nvidia" ];

        # xkb = {
        #   layout = "us,ru,apl";
        #   options = "grp:alt_shift_toggle,grp_led:scroll,compose:menu";
        #   variant = ",,dyalog";
        # };
        xkb = {
          layout = "us,ru";
          options = "grp:alt_shift_toggle,grp_led:scroll,compose:menu";
          variant = "qwerty";
        };
        gdk-pixbuf.modulePackages = with pkgs; [ librsvg ];

        desktopManager = {
          xterm.enable = true;
        };

        displayManager = {
          lightdm = {
            enable = true;
            background = "${pkgs.wallpapers}/IMG_209880gs.jpg";
            greeters.mini = {
              enable = true;
              user = "user";
              extraConfig = ''
                [greeter]
                show-password-label = true
                [greeter-theme]
                window-color = "#DBDBDB"
                background-color = "#000000"
              '';
            };
          };
        };

      };
    }
  ]);

}
