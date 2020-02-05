{ stdenv, pkgs }:
(pkgs.emacsPackagesGen pkgs.emacs).emacsWithPackages (epkgs: ((with epkgs.melpaPackages; [
  (pkgs.runCommand "default.el" {} ''
    mkdir -p $out/share/emacs/
    cp -r ${./site-lisp} $out/share/emacs/site-lisp
  '')
  use-package
  gruvbox-theme
  vterm
  evil
  magit
  windata
  which-key smex
  dashboard
  parinfer
  clojure-mode cider
  nix-mode
  hy-mode
]) ++ (with epkgs.melpaStablePackages; [
  # fzf
]) ++ (with epkgs.elpaPackages; [
  company
  undo-tree
])))
