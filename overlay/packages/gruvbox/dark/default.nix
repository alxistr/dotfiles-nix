{ pkgs, stdenv, lib }:

stdenv.mkDerivation rec {
  name = "gruvbox-dark";
  pname = "gruvbox-dark";

  src = ./theme;

  nativeBuildInputs = with pkgs; [ gtk3 ];

  buildPhase = ":";

  installPhase = ''
    mkdir -p $out/share/themes/gruvbox-dark/
    cp -a $src/. $out/share/themes/gruvbox-dark/
  '';

  postFixup = ":";

}
