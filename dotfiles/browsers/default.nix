{ config, pkgs, lib, ... }:
let cfg = config.nixos-config.own.gui; in
with lib; with types;
{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # (callPackage ./google-chrome.nix {
      #   gconf = gnome2.GConf;
      # })
      google-chrome
      vivaldi
    ];

    programs = {
      firefox = {
        enable = true;
        extensions = [ ];
      };

      chromium = {
        enable = true;
        extensions = [
          "dbepggeogbaibhgnhhndojpepiihcmeb"  # vimium
          "gcbommkclmclpchllfjekcdonpmejbdp"  # https everywhere
          "padekgcemlokbadohgkifijomclgjgif"  # proxy switchyomega
          "gighmmpiobklfepjocnamgkkbiglidom"  # adblock
          "cfhdojbkjhnklbpkdaibdccddilifddb"  # adblock plus
          "cmedhionkhpnakcndndgjdbohmhepckk"  # adblock youtube
          "aapbdbdomjkkjkaonfhkkikfgjllcleb"  # google translate
        ];
      };

    };

  };

}
