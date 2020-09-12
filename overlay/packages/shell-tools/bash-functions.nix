{ stdenv }:

stdenv.mkDerivation rec {
  name = "bash-functions";
  src = ./bash-functions;
  unpackPhase = ":";
  buildPhase = ''
    find $src -type f -name "*.sh" | xargs cat > $out
  '';
  installPhase = ":";
}

