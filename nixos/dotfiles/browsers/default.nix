{ config, pkgs, lib, ... }:
let cfg = (import <nixpkgs/nixos> {}).config.own.gui; in
with lib; with types;
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      google-chrome
      vivaldi
      vivaldi-ffmpeg-codecs
    ];

    programs = {
      firefox = {
        enable = true;
        enableAdobeFlash = true;
        enableGoogleTalk = true;
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
          "gjjpophepkbhejnglcmkdnncmaanojkf"  # plus for trello
        ];
      };

    };

  };

}
