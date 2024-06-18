{ config, pkgs, lib, osConfig, ... }:
let cfg = osConfig.own.gui; in
with lib; with types;

{
  config = mkIf cfg.enable {
    home.packages = with pkgs; ([
      gparted
      exfat
      dosfstools
      mtools
      gvfs

      deadbeef
      # cmus
      mpv

      qpdfview
      djview
      # masterpdfeditor

      bless
      scanmem

      sublime3

    ] ++ optionals cfg.heavy [
      ffmpeg
      mkvtoolnix

      anki-bin

      # jetbrains.pycharm-professional
      # jetbrains.idea-ultimate
      jetbrains.idea-community

      # youtube-dl
      yt-dlp
      # (youtube-dl.overrideAttrs (oldAttrs: {
      #   src = builtins.fetchGit{
      #     url = "https://github.com/ytdl-org/youtube-dl";
      #     rev = "fa7f0effbe4e14fcf70e1dc4496371c9862b64b9";
      #   };
      #   patches = [];
      #   postInstall = "";
      # }))
      # bandcamp-downloader
      # scdl

      appimage-run
      apacheHttpd

      # zoom-us
      discord

      # tor-browser-bundle-bin

      # nixops
      # fabric1
      # scaleway-cli
      # dysnomia
      # disnix

      podman
      kubectl
      kubernix
      kubectx

      gnumake
      openjdk
      clojure
      visualvm
      async-profiler

      # shen
      # ferret
      fennel
      chez
      babashka

      gnuapl
      cbqn
      # j

      erlang
      gprolog
      # swiProlog

      # ghc
      # ghcid
      # stack
      # hlint
      # ormolu
      # stylish-haskell
      # haskellPackages.hoogle

      # purescript
      # elmPackages.elm
      # elmPackages.elm-format
      # elmPackages.elm-test-rs

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

      xournalpp
      # (xmind.override { jre = jre8; })
      # seqdiag
      freemind
      zim
      graphviz
      plantuml

      # gthumb
      # aseprite-unfree
      xnview
      feh
      krita
      aseprite

      godot3
      gdx-liftoff

      puredata
      supercollider

      transmission-gtk

      # android-file-transfer
      go-mtpfs

      shell-tools.subs-to-chapters
      shell-tools.extract-subs
      shell-tools.ipynb-to-py
      shell-tools.create-androidenv-shell

    ]);

    # programs.opam = {
    #   enable = true;
    #   enableBashIntegration = true;
    # };

    home.file.".ideavimrc".source = ./ideavimrc;
    home.file.".config/mpv/input.conf".source = ./mpv-input.conf;
    home.file.".cmus/gruvbox-light.theme".source = ./cmus.theme;
    home.file.".XCompose".source = "${pkgs.keyd}/share/keyd/keyd.compose";

    # https://github.com/practicalli/clojure-deps-edn
    home.activation.setup-clojure-edn = ''
      mkdir -p ~/.clojure
      [[ -f "~/.clojure/deps.edn" ]] || cp -f ${./deps.edn} ~/.clojure/deps.edn
    '';

  };

}
