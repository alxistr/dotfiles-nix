{ callPackage, stdenv, pkgs, parinfer-rust }:

(pkgs.emacsPackagesGen pkgs.emacs).emacsWithPackages (epkgs: ((with epkgs.melpaPackages; [
  use-package
  gruvbox-theme 
  evil which-key smex ido-vertical-mode ido-yes-or-no
  vterm
  magit
  # windata
  origami
  clojure-mode cider
  nix-mode
  hy-mode
]) ++ (with epkgs.melpaStablePackages; [
  # fzf
]) ++ (with epkgs.elpaPackages; [
  company
  undo-tree
]) ++ [
  (callPackage ./parinfer-rust-mode { })
  (pkgs.runCommand "emacs-config" {} ''
    mkdir -p $out/share/emacs/
    cp -r ${./site-lisp} $out/share/emacs/site-lisp
  '')
]))
