{ stdenv, fetchurl, unzip, zlib, autoPatchelfHook }:

stdenv.mkDerivation rec {
  name = "babashka-${version}";
  version = "0.0.62";

  src = fetchurl {
    url = "https://github.com/borkdude/babashka/releases/download/v0.0.62/babashka-${version}-linux-amd64.zip";
    sha256 = "03gqdqsd2f521srzwdlrs65n6vwkg8hlwqh591c0kvy29bchq04y";
  };

  nativeBuildInputs = [
    unzip
    autoPatchelfHook
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    zlib
  ];

  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
    install -m755 -D bb $out/bin/bb
  '';

}

