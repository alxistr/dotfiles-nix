function traceroute-mapper () {
  xdg-open "https://stefansundin.github.io/traceroute-mapper/?trace=$(traceroute -q1 $* | sed ':a;N;$!ba;s/\n/%0A/g')"
}

function run-ssh-tunnel () {
  local server=$1
  local port=${2:-9191}
  local host="0.0.0.0"
  if [ -z "$server" ]; then
    echo "Usage: run-ssh-tunnel <server> [<port>]"
    return
  fi
  echo "Start socks5 on $host:$port"
  ssh -D $host:$port $server -N
}

function run-sshuttle () {
  sshuttle -v --dns 0.0.0.0/0 -r $1
}

function get-my-ip () {
  curl -s $@ https://httpbin.org/ip | jq '.origin'
}

function _check-proxy () {
  if [ -z "$2" ]; then
    echo "Usage: check-<proxy|socks4|socks5>-proxy <host:port>"
    return
  fi
  direct=$(get-my-ip)
  withproxy=$(get-my-ip --$1 $2)
  echo "Direct: $direct"
  echo "With proxy: $withproxy"
  if [ -z "$withproxy" ] || [ "$direct" == "$withproxy" ]; then
    echo -e "\e[1;31mBAD\e[m"
  else
    echo -e "\e[1;32mGOOD\e[m"
  fi
}

function check-http-proxy () {
  _check-proxy proxy $1
}

function check-socks4-proxy () {
  _check-proxy socks4 $1
}

function check-socks5-proxy () {
  _check-proxy socks5 $1
}

function run-with-socks5 () {
  if [ -z "$1" ]; then
    echo "Usage: run-with-socks5 <host:port> <command> [<args...>]"
    return
  fi
  PROXYCHAINS_SOCKS5=$1 proxychains ${@:2}
}

function run-with-tor () {
  run-with-socks5 localhost:9050 ${1:-/bin/bash}
}

function anything-with-proxy () {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: anything-with-proxy <proxy|socks4|socks5> <host:port>"
    return
  fi
  curl -s --$1 $2 http://httpbin.org/anything | jq '.'
}

# function run-tor-proxy () {
#   docker run --name=tor --rm -it -p 8118:8118 -p 9050:9050 -e TZ=UTC -d dperson/torproxy
# }

# function tor-new-nym () {
#   V="echo -e 'AUTHENTICATE \"'\"\$(cat /etc/tor/run/control.authcookie)\"'\"\nSIGNAL NEWNYM\nQUIT' | nc 127.0.0.1 9051"
#   docker exec -it tor /bin/bash -c "$V"
# }

function find-proxies () {
  docker-run alxgrmv/proxybroker find --lvl High --types SOCKS5 --strict -f json | sed '1,2d; s/,\r$/\r/; $d'
}

function find-ru-proxies () {
  docker-run alxgrmv/proxybroker find --lvl High --types SOCKS5 --strict --countries RU $@
}

function run-zap () {
  docker run --name=zap -d --rm -u zap -p 6770:8080 -p 6771:8090 -i owasp/zap2docker-stable zap-webswing.sh
  xdg-open "http://127.0.0.1:6770/?anonym=true&app=ZAP"
}

# function clean-routes () {
#   tun=${1:-tun1}
#   ip ro | grep $tun | cut -d' ' -f1 | grep -v "10\." | while read line; do
#     sudo ip ro del $line
#   done
#   ip ro | grep $tun
# }

