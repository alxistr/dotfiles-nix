function generate-password () {
  < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;
}

function gpg-encrypt () {
    gpg -o - --cipher-algo AES256 -a -c $1
}

function gpg-decrypt () {
    gpg -o - -d $1
}

function reload-agent () {
    killall ssh-agent
    eval `ssh-agent`
}

function datetime-stamp () {
    date -u --iso-8601=seconds | sed 's/[^0-9]//g'
}

