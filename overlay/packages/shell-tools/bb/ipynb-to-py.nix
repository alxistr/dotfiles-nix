{ stdenv, babashka }:

stdenv.mkDerivation rec {
  name = "ipynb2py";
  src = ./ipynb-to-py.clj;

  buildInputs = [
    babashka
  ];

  unpackPhase = ":";
  buildPhase = ":";
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/ipynb-to-py
  '';

}
