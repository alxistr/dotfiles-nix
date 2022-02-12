{ config, pkgs, lib, ... }:

let
  emacs-overlay = builtins.fetchGit {
    url = "https://github.com/nix-community/emacs-overlay/";
    rev = "692493e39df9e414c0ac71c2f30535c1f09aafef";
  };

  neovim-overlay = builtins.fetchGit {
    url = "https://github.com/nix-community/neovim-nightly-overlay/";
    rev = "08b5db099c74e2f266464f9f2b6f821a0183590b";
  };

  unstable = import <nixos-unstable> {};

in

{
  config = {
    nixpkgs.config = {
      allowUnfree = true;
      allowBroken = false;
    };
    nixpkgs.overlays = [
      ( import "${emacs-overlay}" )
      ( import "${neovim-overlay}" )
      ( import ../../overlay )
      ( self: super: { clojure = unstable.clojure; } )
    ];
  };
}
