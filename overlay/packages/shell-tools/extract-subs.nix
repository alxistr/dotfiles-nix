{ writeScriptBin, ccextractor }:

writeScriptBin "extract-subs" ''
  ${ccextractor}/bin/ccextractor -o ass "''$@"
''
