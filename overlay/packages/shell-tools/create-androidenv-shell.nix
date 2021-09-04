{ writeScriptBin }:

writeScriptBin "create-androidenv-shell" ''
  [[ ! -f "./shell.nix" ]] && \
    cp -f ${./androidenv-shell.nix} ./shell.nix && \
    chmod +w ./shell.nix || \
    echo "shell.nix already exists!"
  echo "done"
''
