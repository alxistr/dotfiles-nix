{ pkgs, stdenv, lib, fennel }:

let
  getLuaPath = lib : dir : "${lib}/${dir}/lua/${pkgs.luaPackages.lua.luaversion}";
  makeSearchPath = lib.concatMapStrings (path:
    " --search " + (getLuaPath path "share") +
    " --search " + (getLuaPath path "lib")
  );

  awesomeLuaPackages = with pkgs; [
    awesome-freedesktop
    lua-moses
    (pkgs.luaPackages.inspect)
  ];

in

stdenv.mkDerivation rec {
  name = "awesome-debug";

  buildInputs = with pkgs; [
    awesomerc
    (writeScriptBin "awesome" ''
      ${awesome}/bin/awesome ${makeSearchPath awesomeLuaPackages} $@
    '')
  ];

  ARC = pkgs.awesomerc;
  D = 1;
  SCREEN_SIZE = "1400x900";
  AWESOME_OPTIONS = "";
  XEPHYR_OPTIONS = "";

  shellHook = ''
    awesome_pid() { pgrep -n "awesome"; }
    xephyr_pid() { pgrep -f xephyr_$D; }
    errorout() { echo "error: $*" >&2; exit 1; }

    HOME=/.homelessshelter
    XDG_CONFIG_HOME=/.homelessshelter

    start () {
      (
        set -x

        # check for free $DISPLAYs
        for ((i=0;;i++)); do
          if [[ ! -f "/tmp/.X$i-lock" ]]; then
            D=$i;
            break;
          fi;
        done

        RC_FILE=$ARC/rc.lua

        Xephyr :$D -name xephyr_$D -ac -br -noreset -screen "$SCREEN_SIZE" $XEPHYR_OPTIONS >/dev/null 2>&1 &
        sleep 1
        DISPLAY=:$D.0 awesome -c "$RC_FILE" --search "$ARC" $AWESOME_OPTIONS &
        sleep 1

        echo "Using a test file ($RC_FILE)"

        echo "Display: $D, Awesome PID: $(awesome_pid), Xephyr PID: $(xephyr_pid)"

      )
    }

    stop () {
      (
        set -x

        if [[ "$1" == all ]]; then
          echo "Stopping all instances of Xephyr"
          kill $(pgrep Xephyr) >/dev/null 2>&1
        elif [[ $(xephyr_pid) ]]; then
          echo "Stopping Xephyr for display $D"
          kill $(xephyr_pid)
        else
          echo "Xephyr is not running or you did not specify the correct display with -D"
          exit 0
        fi
      )
    }

    start

  '';

}
