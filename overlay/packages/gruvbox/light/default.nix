{ pkgs, stdenv, lib }:

stdenv.mkDerivation rec {
  name = "gruvbox-light";
  pname = "gruvbox-light";

  src = ./theme;

  nativeBuildInputs = with pkgs; [ gtk3 ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p $out/share/themes/gruvbox-light/
    cp -a $src/. $out/share/themes/gruvbox-light/
  '';

  postFixup = ":";

}
