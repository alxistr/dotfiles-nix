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
      mpv

      qpdfview
      djview

      bless
      scanmem

      sublime3

    ] ++ optionals cfg.heavy [
      ffmpeg
      mkvtoolnix

      anki-bin

      jetbrains.idea-community

      yt-dlp

      appimage-run
      apacheHttpd

      discord

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

      love_11
      exercism

      # joplin-desktop

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

      ## signal analysis
      # mpg123
      # baudline
      audacity
      friture
      puredata
      plugdata
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
