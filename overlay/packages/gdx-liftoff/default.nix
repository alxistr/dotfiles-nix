{ writeScriptBin, bash, jdk, fetchurl }:

let
  # https://github.com/tommyettinger/gdx-liftoff/releases
  version = "1.10.0.6";
  jar = fetchurl {
    url = "https://github.com/tommyettinger/gdx-liftoff/releases/download/v${version}/gdx-liftoff-${version}.jar";
    sha256 = "0iw65ncq3bcj49z79zpszi82mdf8b96a2zpz52gbplqds8wbwjbd";
  };
in

writeScriptBin "gdx-liftoff" ''
  #!${bash}/bin/bash
  ${jdk}/bin/java -jar ${jar} $@
''

