{ pkgs, stdenv, lib }:
stdenv.mkDerivation rec {
  name = "Flat-Remix";
  pname = "Flat-Remix";
  src = builtins.fetchGit {
    url = "https://github.com/daniruiz/flat-remix/";
    rev = "fd49025def58f591ce227b2c7eb05b69845bbeec";  # 20190503
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
