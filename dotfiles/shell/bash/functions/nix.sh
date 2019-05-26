function which-n-where () {
  realpath $(which $1)
}

function nx-show-dependencies() {
  nix-store --query --references $(which $1)
}

function nx-show-rdependencies() {
  nix-store --query --referrers $(which $1)
}

function nx-cleanup () {
  nix-collect-garbage -d && nix-store --optimise
}
