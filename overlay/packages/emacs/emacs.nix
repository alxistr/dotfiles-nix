{ stdenv, pkgs }:

let emacsWithPackages = (pkgs.emacsPackagesGen pkgs.emacs).emacsWithPackages; in

let emacs = (emacsWithPackages (epkgs: (with epkgs.melpaPackages; [
  use-package
  parinfer
  vterm
  nix-mode
  magit
  which-key
]) ++ (with epkgs.melpaStablePackages; [
  gruvbox-theme
  # magit
  # fzf
  evil
]) ++ (with epkgs.elpaPackages; [
  undo-tree
]))); in

let emacsd = ./emacs.d; in

pkgs.writeScriptBin "emacs" ''
  #!${pkgs.stdenv.shell}
  exec ${emacs}/bin/emacs -q -l ${emacsd}/init.el $@
''
