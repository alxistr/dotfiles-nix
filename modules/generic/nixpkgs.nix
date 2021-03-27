{ config, pkgs, lib, ... }:

let emacs-overlay = builtins.fetchGit {
  url = "https://github.com/nix-community/emacs-overlay/";
  rev = "692493e39df9e414c0ac71c2f30535c1f09aafef";
}; in

{
  config = {
    nixpkgs.config = {
      allowUnfree = true;
      allowBroken = false;
    };
    nixpkgs.overlays = [
      ( import "${emacs-overlay}" )
      ( import ../../overlay )
    ];
  };
}
