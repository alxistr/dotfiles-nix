{ pkgs, stdenv, lib, fennel }:

stdenv.mkDerivation rec {
  name = "awesomerc";
  src = ./src;

  unpackPhase = ":";

  buildPhase = ''
    compile () {
      filename=$1
      target=$(basename $filename)
      target=$out/''${target/.fnl/.lua}
      mkdir -p $(dirname $target)
      ${fennel}/bin/fennel --compile $filename > $target
    }

    find $src -type f -name "*.fnl" | \
    while read filename; do
      compile $filename;
    done

    cp -r $src/lua $out
    cp -r $src/static $out

    substituteInPlace $out/nix.lua \
       --replace @awesomerc@ "$out"

  '';

  installPhase = ":";

}
