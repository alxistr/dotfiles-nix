function mpv-va () {
    mpv --audio-file="$2" "$1"
}

function mpv-vas () {
    mpv --sub-file="$3" --audio-file="$2" "$1"
}

function mpv-vs () {
    mpv --sub-file="$2" "$1"
}

function mpv-loop () {
    mpv --loop=inf "$@"
}

function fix-opus-codec () {
  local filename=$1
  local codec=$(exiftool "$filename" | grep A_OPUS)
  if [[ -z $codec ]]; then
    echo "Is not opus codec"
    return
  fi
  local newfilename=$(echo $filename | sed -e 's/\.\(.*\)$/-vorbis.\1/')
  ffmpeg -i "$filename" -acodec libvorbis -vcodec copy "$newfilename" && \
  echo "Done; filename $newfilename"
}

function split-image-in-two () {
  local name=`echo $1 | cut -d'.' -f1`
  local ext=`echo $1 | cut -d'.' -f2`
  name=${2:-$name}
  convert $1 -gravity East -crop 50%x100%+0+0 ${name}-right.$ext
  convert $1 -gravity West -crop 50%x100%+0+0 ${name}-left.$ext
}

# function run-with-steam () {
#   local P=$(pwd)
#   $(realpath ~)/.steam/bin32/steam-runtime/run.sh "${P}/${1}"
#   cd $P
# }

function micon () {
  pactl load-module module-loopback latency_msec=1
}

function micoff () {
  pactl unload-module module-loopback
}

