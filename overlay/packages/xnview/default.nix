{ pkgs, stdenv, lib }:

with pkgs;

stdenv.mkDerivation rec {
  name = "xnview";
  src = builtins.fetchTarball {
    url = "https://download.xnview.com/XnViewMP-linux-x64.tgz";
    sha256 = "1xlf8fxs2dbgncawmjgf7a48jc8wmk4hi4s0iwmarxccy6arxz1d";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    xorg.libX11
    libpulseaudio
    zlib
    libglvnd
    alsaLib
    gst_all_1.gst-plugins-base
    fontconfig.lib
    freetype
    libdrm
    xlibs.libXi
    xlibs.libXv
    gnome2.pango
    gtk2-x11
    gtk3-x11
    sqlite
    openal
    (callPackage ./bzip2.nix { }).out
  ];

  sourceRoot = ".";
  buildPhase = ":";

  installPhase = ''
    mkdir -p $out/bin
    cp -a $src/. $out/
    ln -s $out/xnview.sh $out/bin/xnview
  '';

}
