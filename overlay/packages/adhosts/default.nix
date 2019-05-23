{ pkgs, stdenv, lib }:
stdenv.mkDerivation rec {
  name = "adhosts";
  src = builtins.fetchurl "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
  unpackPhase = ":";
  buildPhase = ''
    awk '/^0.0.0.0 / { printf "address=/%s/0.0.0.0\n", $2 }' $src > $out 
  '';
  installPhase = ":";
}
