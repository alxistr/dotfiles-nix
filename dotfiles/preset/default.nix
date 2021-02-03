{ config, pkgs, lib, ... }:
let cfg = config.nixos-config.own.gui; in
with lib; with types;

{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      pasystray
      pavucontrol
      paprefs

      gparted
      gvfs

      cmus
      mpv
      ffmpeg

      qpdfview
      djview
      masterpdfeditor
      #(fbreader.override { uiType = "gtk"; })
      fbreader

      xnview
      feh
      # gthumb
      krita
      # aseprite-unfree
      xournalpp
      xmind
      zim
      graphviz
      seqdiag

      transmission-gtk

      # android-file-transfer
      go-mtpfs

      wxhexeditor
      scanmem

      sublime3

      (jetbrains.pycharm-professional.overrideAttrs (oldAttrs: rec {
        name = "pycharm-professional-${version}";
        version = "2020.3.2";
        src = fetchurl {
          url = "https://download.jetbrains.com/python/${name}.tar.gz";
          sha256 = "1fbb8v40q7vgn5v5dyxb211abr8swnxa3gw18kh3vlk6yc2crzfw";
        };
      }))
      (jetbrains.idea-ultimate.overrideAttrs (oldAttrs: rec {
        name = "idea-ultimate-professional-${version}";
        version = "2020.3.1";
        src = fetchurl {
          url = "https://download.jetbrains.com/idea/ideaIU-${version}-no-jbr.tar.gz";
          sha256 = "1kwz0aq4b664awppakj4syppk218nynwxv4ngc7pa3k9v4g2sdah";
        };
      }))

      youtube-dl
      # bandcamp-downloader
      scdl

      appimage-run
      apacheHttpd

      zoom-us
      discord

      # tor-browser-bundle-bin

      nixops
      fabric1
      scaleway-cli
      dysnomia
      disnix
      kubernix
      podman

      openjdk11
      leiningen
      clojure
      visualvm

      fennel
      # ferret
      babashka
      chez

      erlang
      gprolog

      love_11
      exercism

      joplin-desktop

      ## signal analysis
      # mpg123
      # baudline
      audacity

    ];

    home.file.".ideavimrc".source = ./ideavimrc;
    home.file.".config/mpv/input.conf".source = ./mpv-input.conf;

    # https://github.com/practicalli/clojure-deps-edn
    home.activation.setup-clojure-edn = ''
      mkdir -p ~/.clojure
      [[ -f "~/.clojure/deps.edn" ]] || cp -f ${./deps.edn} ~/.clojure/deps.edn
    '';

  };

}
