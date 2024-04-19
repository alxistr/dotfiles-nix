{ config, pkgs, lib, ... }:

let
  # emacs-overlay = builtins.fetchGit {
  #   url = "https://github.com/nix-community/emacs-overlay/";
  #   rev = "ccefa5f7ddbb036656d8617ed2862fe057d60fb4";
  # };

  # neovim-overlay = builtins.fetchGit {
  #   url = "https://github.com/nix-community/neovim-nightly-overlay/";
  #   rev = "72ff8b1ca0331a8735c1eeaefb95c12dfe21d30a";
  # };

  unstable = import <nixos-unstable> {};

in

{
  config = {
    nixpkgs.config = {
      allowUnfree = true;
      allowBroken = false;
      cudaSupport = true;
    };
    nixpkgs.overlays = [
      # ( import "${emacs-overlay}" )
      # ( import "${neovim-overlay}" )
      ( import ../../overlay )
      ( self: super: {
          # clojure = unstable.clojure;
          cbqn = unstable.cbqn;
      } )
    ];
  };
}
