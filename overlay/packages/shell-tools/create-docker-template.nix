{ writeScriptBin }:

writeScriptBin "create-docker-template" ''
  [[ ! -f "./.docker.bash" ]] && \
    cp -f ${./docker-template.bash} ./.docker.bash && \
    chmod +w ./.docker.bash || \
    echo ".docker.bash already exists!"

  cat >./.entry.bash <<EOF
  #!/usr/bin/env bash
  source ./.docker.bash
  \$@
  EOF
  chmod +x ./.entry.bash

  [[ ! -f "./Dockerfile" ]] && cat >./Dockerfile <<EOF
  FROM python:3.5

  RUN pip install \\
    requests \\
    ipython \\
    hy

  EOF

  echo "done"

''
