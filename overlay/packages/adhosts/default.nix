{ pkgs, stdenv, lib }:

let whitelist = pkgs.writeTextFile {
  name = "adhosts-whitelist";
  text = ''
    binance.com
  ''; 
}; in

stdenv.mkDerivation rec {
  name = "adhosts";
  src = builtins.fetchurl "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
  unpackPhase = ":";
  buildPhase = ''
    grep -Fv -f ${whitelist} $src | \
    awk '/^0.0.0.0 / { printf "address=/%s/0.0.0.0\n", $2 }' > \
    $out 
  '';
  installPhase = ":";
}
