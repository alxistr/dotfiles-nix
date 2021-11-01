{ config, pkgs, lib, ... }:

let
  emacs-overlay = builtins.fetchGit {
    url = "https://github.com/nix-community/emacs-overlay/";
    rev = "692493e39df9e414c0ac71c2f30535c1f09aafef";
  };

  neovim-overlay = builtins.fetchGit {
    url = "https://github.com/nix-community/neovim-nightly-overlay/";
    rev = "7d1ccc9e3115f11c1b65e6793b56678bb3caab19";
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
