{ pkgs, stdenv, lib, fennel }:

stdenv.mkDerivation rec {
  name = "awesomerc";
  src = ./src;

  unpackPhase = ":";

  buildPhase = ''
    compile () {
      filename=$1
      target=$out/$filename
      target=''${target/\.fnl/\.lua}
      target=''${target/\/fnl\//\/lua\/}
      echo $target
      mkdir -p $(dirname $target)
      ${fennel}/bin/fennel --compile $src/$filename > $target
    }

    find $src -type f -name "*.fnl" | \
    while read filename; do
      filename=$(realpath --relative-to="$src" "$filename")
      compile $filename;
    done

    cp -r $src/lua $out
    cp -r $src/static $out

    substituteInPlace $out/lua/nix.lua \
       --replace @awesomerc@ "$out"
  '';

  installPhase = ":";

}
