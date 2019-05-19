{ pkgs, stdenv, lib }:
stdenv.mkDerivation rec {
  name = "Flat-Remix";
  pname = "Flat-Remix";
  src = fetchTarball "https://github.com/daniruiz/flat-remix/archive/20190427.tar.gz";
  nativeBuildInputs = with pkgs; [ gtk3 ];
  installPhase = ''
    mkdir -p $out/share/icons
    mv Flat-Remix* $out/share/icons/
  '';
  postFixup = ''
    for theme in $out/share/icons/*; do
      gtk-update-icon-cache $theme
    done
  '';
}
