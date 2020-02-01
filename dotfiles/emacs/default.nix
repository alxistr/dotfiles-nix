{ config, pkgs, lib, ... }:

let opts = config.nixos-config.own.emacs; in
with lib; with types;

{
  config = mkIf opts.enable {
    programs.bash = {
      shellAliases = {
        emacs = "emacs -nw";
      };
    };

    programs.emacs = {
      enable = true;
      extraPackages = (epkgs: ((with epkgs.melpaPackages; [
        use-package
        gruvbox-theme
        vterm
        evil
        magit
        which-key smex
        dashboard
        parinfer
        clojure-mode cider
        nix-mode
      ]) ++ (with epkgs.melpaStablePackages; [
        # fzf
      ]) ++ (with epkgs.elpaPackages; [
        company
        undo-tree
      ])));
    };

    home.file.".emacs.d/init.el".source = ./init.el;

  };

}
