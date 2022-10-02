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

function nx-update () {
  nix-channel --update && \
  nixos-rebuild switch && \
  nx-cleanup
}

function nx-gc-roots () {
  find -H /nix/var/nix/gcroots/auto -type l | xargs -I {} sh -c 'readlink {}; realpath {}; echo'
}
