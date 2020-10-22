{ pkgs, symlinkJoin, writeScriptBin, fennel }:

let
  # src = ./fnl;

  fnlns = writeScriptBin "fnlns" ''
    ${fennel}/bin/fennel \
       --add-fennel-path "${./fnl}/?.fnl" \
       --load ${./fnl}/fennelns/patch.fnl \
       $@
  '';

  fnlnsf = writeScriptBin "fnlnsf" ''
    ${fnlns}/bin/fnlns --compile $1
  '';

  fnlnsd = writeScriptBin "fnlnsd" ''
    dst="$1"
    mkdir -p $dst/{fnl,lua}
    dst=$(realpath $dst)

    src="$(realpath $2)"

    compile () {
      filename="$1"
      output="$dst/fnl/$filename"
      output=''${output/\.fnl/\.lua}
      output=''${output/\/fnl\//\/lua\/}
      echo "Compile $filename to $output"
      mkdir -p "$(dirname $output)"
      ${fnlnsf}/bin/fnlnsf "$src/$filename" > $output
    }

    compile-dir () {
      (
        cd "$1"
        find . -type f -name "*.fnl" -not -name "*macro*.fnl" | \
        while read filename; do
          filename=$(realpath --relative-to="$(pwd)" "$filename")
          compile "$filename";
        done
      )
    }

    copy-macroses () {
      (
        path="$1"
        cd $path
        find . -type f -name "*macro*.fnl" | \
        while read filename; do
          filename=$(realpath --relative-to="$(pwd)" "$filename")
          mkdir -p "$(dirname "$dst/fnl/$filename")"
          echo "$dst/fnl/$filename"
          cp -f "$path/$filename" "$dst/fnl/$filename"
        done
      )
    }

    echo "* Compiling fennel files..."
    (
      compile-dir "$src"
    )

    echo "* Coping macroses..."
    copy-macroses "${./fnl}"
    copy-macroses "$src"

    echo "* Done"

    # ${pkgs.tree}/bin/tree $dst

  '';

in

symlinkJoin {
  name = "fennelns";
  paths = [
    fnlns
    fnlnsf
    fnlnsd
  ];
}
