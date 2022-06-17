{ pkgs, stdenv, lib }:

with pkgs;

stdenv.mkDerivation rec {
  name = "xnview";
  src = builtins.fetchTarball {
    url = "https://download.xnview.com/XnViewMP-linux-x64.tgz?_=20201025";
    sha256 = "1h0mx8wxas6krpkfp0i9dncg4y20jn46jszqd3nssgmak772lrpx";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    xorg.libX11
    xorg.libxcb
    xorg.libXi
    xorg.libXv
    xorg.libXfixes
    xorg.libXrender
    xorg.libXcomposite
    xorg.libXext
    libglvnd
    zlib
    libdrm
    libpulseaudio
    openal
    alsaLib
    glib
    sqlite
    krb5
    gst_all_1.gst-plugins-base
    qt5.qtmultimedia
    qt5.qtwebsockets
    fontconfig
    gtk2-x11
    gtk3-x11
    freetype
    (callPackage ./bzip2.nix { }).out
  ];

  sourceRoot = ".";
  buildPhase = ":";

  preFixup = ''
    rm $out/lib/imageformats/libqpdf.so
    # rm $out/lib/platforms/libqwayland-egl.so
    rm $out/lib/platforms/libqwayland-*.so
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -a $src/. $out/
    ln -s $out/xnview.sh $out/bin/xnview
  '';

  dontWrapQtApps = true;

}
