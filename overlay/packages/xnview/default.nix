{ pkgs, stdenv, lib }:
stdenv.mkDerivation rec {
  name = "xnview";
  src = builtins.fetchTarball "https://download.xnview.com/XnViewMP-linux-x64.tgz";
  sourceRoot = ".";
  buildPhase = ":";
  installPhase = ''
    mkdir -p $out/bin
    cp -a $src/. $out/
    ln -s $out/XnView $out/bin/XnView
    ln -s $out/xnview.sh $out/bin/xnview.sh
  '';
  # preFixup = ''
  #   # export LD_LIBRARY_PATH="$dirname/lib:$dirname/Plugins:$LD_LIBRARY_PATH"
  #   # export QT_PLUGIN_PATH="$dirname/lib:$QT_PLUGIN_PATH"
  #   patchelf \
  #     --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
  #     --set-rpath "$src/lib:$src/Plugins" \
  #     $out/XnView
  # '';
  preFixup = let
    libPath = lib.makeLibraryPath (with pkgs; [
      xorg.libX11
      libpulseaudio
      # libpressureaudio
      # qt5.qtbase
      # qt5.qtmultimedia
      # qt5.qtsvg
      # qt5.qtwebkit
      # qt5.qtx11extras
      # libsForQt5.libqtav
    ]);
  in ''
    patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath "${libPath}:$out/lib:$out/Plugins" \
      $out/XnView
  '';
}
