{ pkgs, symlinkJoin, writeText, writeScriptBin, fennel }:

let
  fnlns = writeScriptBin "fnlns" ''
    ${fennel}/bin/fennel \
       --load ${writeText "static-patch.fnl" ''
          (local fennel (require "fennel"))
          (-> (or package.loaders package.searchers)
              (table.insert fennel.searcher))
          (->> fennel.path
               (.. "${./fnl}/?.fnl;")
               (set fennel.path))
          ((-> (require :fennelns.patch)
               (. :static-patch)))
       ''} \
       $@
  '';

  fnlns-cp-macro = writeScriptBin "fnlns-cp-macro" ''
    (
      src=$1
      dst=$2
      mkdir -p $dst
      cd $src
      find . -type f -name "*.fnl" -name "*macro*.fnl" | \
      while read filename; do
        filename=$(realpath --relative-to=$src $filename)
        cp $filename $dst;
      done
    )
  '';

  fnlns-install = writeScriptBin "fnlns-install" ''
    dst=$1
    mkdir -p $dst/{fnl,lua}

    find ${fennel} \
       -type f -name "*.lua" \
       -exec cp -f {} $dst/lua/ \;

    cp -a "${./fnl}/." $dst/fnl

  '';

  fnlns-file = writeScriptBin "fnlns-file" ''
    ${fnlns}/bin/fnlns --compile $1
  '';

  fnlns-dir = writeScriptBin "fnlns-dir" ''
    src=$1
    dst=$2

    mkdir -p $dst

    compile-file () {
      filename=$1
      dst=$2
      output="$dst$filename"
      output=''${output/\.fnl/\.lua}
      # echo "Compile $filename to $output"
      mkdir -p "$(dirname $output)"
      ${fnlns-file}/bin/fnlns-file \
         $src/$filename > $output
    }

    compile-dir () {
      (
        in=$1
        out=$2
        cd $in
        find . -type f -name "*.fnl" -not -name "*macro*.fnl" | \
        while read filename; do
          filename=$(realpath --relative-to=$in $filename)
          compile-file $filename $out;
        done
      )
    }

    compile-dir $src $dst

  '';

in

symlinkJoin {
  name = "fennelns";
  paths = [
    fnlns
    fnlns-file
    fnlns-dir
    fnlns-cp-macro
    fnlns-install
  ];
}
