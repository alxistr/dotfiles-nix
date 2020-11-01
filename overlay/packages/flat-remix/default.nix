{ pkgs, stdenv, lib }:
stdenv.mkDerivation rec {
  name = "Flat-Remix";
  pname = "Flat-Remix";
  src = builtins.fetchGit {
    url = "https://github.com/daniruiz/flat-remix/";
    rev = "0f3c284e1543cd344561d2beea1f7c540c465cfb";  # 20201017
  };
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
