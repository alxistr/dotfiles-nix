{ config, pkgs, lib, ... }:
let cfg = config.nixos-config.own.gui; in
with lib; with types;

{
  config = mkIf cfg.enable {
    nixpkgs.config.permittedInsecurePackages = [
      "python2.7-pyjwt-1.7.1"
    ];

    home.packages = with pkgs; [
      pasystray
      pavucontrol
      paprefs

      gparted
      exfat
      dosfstools
      mtools
      gvfs

      deadbeef
      # cmus
      mpv
      ffmpeg
      mkvtoolnix

      shell-tools.subs-to-chapters
      shell-tools.extract-subs
      shell-tools.ipynb-to-py
      shell-tools.create-androidenv-shell

      qpdfview
      djview
      # masterpdfeditor
      #(fbreader.override { uiType = "gtk"; })
      fbreader

      xournalpp
      # (xmind.override { jre = jre8; })
      freemind
      zim
      graphviz
      # seqdiag

      xnview
      feh
      # gthumb
      krita
      # aseprite-unfree
      aseprite

      godot
      gdx-liftoff

      transmission-gtk

      # android-file-transfer
      go-mtpfs

      wxhexeditor
      scanmem

      sublime3

      anki-bin

      # jetbrains.pycharm-professional
      # jetbrains.idea-ultimate
      jetbrains.idea-community

      # (jetbrains.pycharm-professional.overrideAttrs (oldAttrs: rec {
      #   name = "pycharm-professional-${version}";
      #   version = "2020.3.2";
      #   src = fetchurl {
      #     url = "https://download.jetbrains.com/python/${name}.tar.gz";
      #     sha256 = "1fbb8v40q7vgn5v5dyxb211abr8swnxa3gw18kh3vlk6yc2crzfw";
      #   };
      # }))
      # (jetbrains.idea-ultimate.overrideAttrs (oldAttrs: rec {
      #   name = "idea-ultimate-professional-${version}";
      #   version = "2020.3.1";
      #   src = fetchurl {
      #     url = "https://download.jetbrains.com/idea/ideaIU-${version}-no-jbr.tar.gz";
      #     sha256 = "1kwz0aq4b664awppakj4syppk218nynwxv4ngc7pa3k9v4g2sdah";
      #   };
      # }))
      # jetbrains.clion

      # youtube-dl
      (youtube-dl.overrideAttrs (oldAttrs: {
        src = builtins.fetchGit{
          url = "https://github.com/ytdl-org/youtube-dl";
          rev = "7bbd5b13d4c6cfc3e24f56413ff1a1eace8472b8";
        };
        patches = [];
        postInstall = "";
      }))
      # bandcamp-downloader
      # scdl

      appimage-run
      apacheHttpd

      zoom-us
      discord

      # tor-browser-bundle-bin

      nixops
      # fabric1
      # scaleway-cli
      dysnomia
      disnix

      podman
      kubectl
      kubernix
      kubectx

      # postman
      openjdk11
      leiningen
      clojure
      visualvm

      # shen
      fennel
      # ferret
      chez
      babashka

      erlang
      gprolog
      swiProlog

      # ocaml
      # opam
      # dune_2
      # bs-platform

      love_11
      exercism

      # joplin-desktop

      ## signal analysis
      # mpg123
      # baudline
      audacity

    ];

    # programs.opam = {
    #   enable = true;
    #   enableBashIntegration = true;
    # };

    home.file.".ideavimrc".source = ./ideavimrc;
    home.file.".config/mpv/input.conf".source = ./mpv-input.conf;
    home.file.".cmus/gruvbox-light.theme".source = ./cmus.theme;

    # https://github.com/practicalli/clojure-deps-edn
    home.activation.setup-clojure-edn = ''
      mkdir -p ~/.clojure
      [[ -f "~/.clojure/deps.edn" ]] || cp -f ${./deps.edn} ~/.clojure/deps.edn
    '';

  };

}
