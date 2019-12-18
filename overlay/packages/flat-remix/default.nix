{ pkgs, stdenv, lib }:
stdenv.mkDerivation rec {
  name = "Flat-Remix";
  pname = "Flat-Remix";
  src = builtins.fetchGit {
    url = "https://github.com/daniruiz/flat-remix/";
    rev = "942efe08edb97fec1ce19076d658689c667d5f60";  # 20191216
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
