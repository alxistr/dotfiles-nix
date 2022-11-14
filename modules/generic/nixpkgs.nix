{ config, pkgs, lib, ... }:

let
  emacs-overlay = builtins.fetchGit {
    url = "https://github.com/nix-community/emacs-overlay/";
    rev = "ccefa5f7ddbb036656d8617ed2862fe057d60fb4";
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
      permittedInsecurePackages = [ "python2.7-pyjwt-1.7.1" ];
    };
    nixpkgs.overlays = [
      ( import "${emacs-overlay}" )
      ( import "${neovim-overlay}" )
      ( import ../../overlay )
      ( self: super: {
          clojure = unstable.clojure;
      } )
    ];
  };
}
