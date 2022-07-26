{ bash, writeScriptBin, inotify-tools }:

writeScriptBin "inotify-watch" ''
  #!${bash}/bin/bash
  while true; do
    $@;
    ${inotify-tools}/bin/inotifywait -e modify -r ./;
  done
''
