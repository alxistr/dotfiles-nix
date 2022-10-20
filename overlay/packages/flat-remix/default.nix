{ pkgs, stdenv, lib }:
stdenv.mkDerivation rec {
  name = "Flat-Remix";
  pname = "Flat-Remix";
  src = builtins.fetchGit {
    url = "https://github.com/daniruiz/flat-remix/";
    # rev = "0f3c284e1543cd344561d2beea1f7c540c465cfb";  # 20201017
    rev = "473534fbcd174ff2aeef090aee7992878c04b718";  # 20220525
  };
  nativeBuildInputs = with pkgs; [ gtk3 ];
  installPhase = ''
    mkdir -p $out/share/icons
    # mv Flat-Remix* $out/share/icons/
    mv Flat-Remix-Grey* $out/share/icons/
  '';
  postFixup = ''
    for theme in $out/share/icons/*; do
      gtk-update-icon-cache $theme
    done
  '';
}
