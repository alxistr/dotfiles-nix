{ pkgs, stdenv, lib }:
stdenv.mkDerivation rec {
  name = "i3lockpp";
  src = ./i3lockpp;
  buildInputs = with pkgs; [
    bash
    scrot
    i3lock
    imagemagick
  ];
  unpackPhase = ":";
  preFixup = with pkgs; ''
    substituteInPlace $out/bin/i3lockpp \
       --replace @i3lock@ "${i3lock}" \
       --replace @imagemagick@ "${imagemagick}" \
       --replace @scrot@ "${scrot}"
  '';
  buildPhase = ":";
  installPhase = ''
    mkdir -p $out/bin/
    cp $src $out/bin/i3lockpp
  '';
}
