function nx-show-dependencies() {
  nix-store --query --references $(which $1)
}

function nx-show-rdependencies() {
  nix-store --query --referrers $(which $1)
}
