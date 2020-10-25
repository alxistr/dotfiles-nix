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
    libglvnd
    zlib
    xlibs.libXi
    xlibs.libXv
    xlibs.libXfixes
    xlibs.libXrender
    xlibs.libXcomposite
    xlibs.libXext
    libdrm
    libpulseaudio
    openal
    alsaLib
    glib
    sqlite_3_31_1
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

}
