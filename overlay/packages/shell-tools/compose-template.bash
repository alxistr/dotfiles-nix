IMAGE_NAME=$(basename $(pwd))
CONTAINER_NAME=$(basename $(pwd))
CMD=""
DETACH=1
DETACH_KEYS="ctrl-d"

function _ensure_running () {
  docker container inspect $CONTAINER_NAME >/dev/null 2>&1
  result=$?
  if [[ $result -eq 0 ]]; then
    true
  else
    echo "Not started"
    false
  fi
}

function _ensure_stopped () {
  docker container inspect $CONTAINER_NAME >/dev/null 2>&1
  result=$?
  if [[ $result -eq 0 ]]; then
    echo "Already started"
    false
  else
    true
  fi
}

function _less () {
  jq -C '.' | less -R
}

function inspect-container () {
  docker container inspect $CONTAINER_NAME | _less
}

function inspect-image () {
  docker image inspect $IMAGE_NAME | _less
}

function status () {
  _ensure_running && echo "running" || echo "stopped"
}

function build () {
  docker build --tag $IMAGE_NAME .
}

function logs () {
  _ensure_running || return
  docker logs --tail=100 --follow $CONTAINER_NAME
}

function root-shell () {
  _ensure_running || return
  docker exec -it -u 0 $CONTAINER_NAME ${@:-/bin/bash}
}

function shell () {
  _ensure_running || return
  docker exec -it $CONTAINER_NAME ${@:-/bin/bash}
}

function attach () {
  _ensure_running || return
  echo "Press \"$DETACH_KEYS\" to detach"
  docker attach --detach-keys "$DETACH_KEYS" $CONTAINER_NAME
}

function start () {
  _ensure_stopped || return
  (
    set -x
    docker run \
      --rm \
      -it \
      $([[ -z $DETACH ]] && echo "" || echo "-d") \
      --name=$CONTAINER_NAME \
      --user=$(id -u) \
      -e HOME=/tmp \
      -v $(pwd):/src/ \
      -w /src/ \
      $IMAGE_NAME ${@:-$CMD}
  )
}

function stop () {
  _ensure_running || return
  docker stop $CONTAINER_NAME
}

function restart () {
  stop
  start
}
