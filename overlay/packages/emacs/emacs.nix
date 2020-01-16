{ stdenv, pkgs }:

let emacsWithPackages = (pkgs.emacsPackagesGen pkgs.emacs).emacsWithPackages; in

let emacs = (emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
  magit
  gruvbox-theme
  evil
]) ++ (with epkgs.elpaPackages; [
  undo-tree
]))); in

let emacsd = ./emacs.d; in

pkgs.writeScriptBin "emacs" ''
  #!${pkgs.stdenv.shell}
  exec ${emacs}/bin/emacs -q -l ${emacsd}/init.el $@
''
