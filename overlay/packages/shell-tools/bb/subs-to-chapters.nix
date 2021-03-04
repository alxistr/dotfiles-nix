{ stdenv, babashka }:

stdenv.mkDerivation rec {
  name = "subs2chapters";
  src = ./subs-to-chapters.clj;

  buildInputs = [
    babashka
  ];

  unpackPhase = ":";
  buildPhase = ":";
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/subs-to-chapters
  '';

}
