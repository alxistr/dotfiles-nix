{ config, pkgs, lib, osConfig, ... }:
let cfg = osConfig.own.gui; in
with lib; with types;
{
  config = mkIf cfg.enable {
    home.packages = with pkgs; optionals cfg.heavy [
      (google-chrome.override { commandLineArgs = "--disable-features=CustomizeChromeSidePanel"; })
      # (vivaldi.override { proprietaryCodecs = true; })
      # brave
      opera
    ];

    programs = {
      # firefox = {
      #   enable = true;
      #   profiles.default = {};
      # };

      chromium = {
        enable = true;
        extensions = [
          "dbepggeogbaibhgnhhndojpepiihcmeb"  # vimium
          "gcbommkclmclpchllfjekcdonpmejbdp"  # https everywhere
          "padekgcemlokbadohgkifijomclgjgif"  # proxy switchyomega
          "cjpalhdlnbpafiamejdnhcphjbkeiagm"  # ublock
          "nffaoalbilbmmfgbnbgppjihopabppdk"  # video speed controller
          "aapbdbdomjkkjkaonfhkkikfgjllcleb"  # google translate
          "clngdbkpkpeebahjckkjfobafhncgmne"  # stylus
        ];
      };

    };

  };

}
