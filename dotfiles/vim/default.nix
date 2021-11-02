{ config, pkgs, lib, ... }:

let enable = config.nixos-config.own.neovim; in
with lib; with types;

let
  plugins = (pkgs.callPackage ./plugins.nix { });

  my-neovim = with pkgs; (neovim.override {
    viAlias = true;
    vimAlias = true;

    withNodeJs = false;
    withRuby = false;
    withPython = false;
    withPython3 = false;

     configure = {
       packages.myVimPackage = with vimPlugins; with plugins; {
         start = [
           mysetup
           vim-nix
           vim-gruvbox8
           parinfer-rust
           vim-airline
           vim-airline-themes
           vim-surround
           # vim-fugitive
           vim-gitgutter
           fzf-vim
           ranger-vim
           deol-nvim
           vimagit
           fennel-vim
           prolog-vim

           # nvim-lspconfig
           # completion-nvim

           # LanguageClient-neovim
           # vim-sexp
           # deol-nvim
           # vim-hy
           # guile-vim
           # vim-fireplace
           # vim-clojure-static
           # vim-iced

         ];
         opt = [ ];
       };

     };
  });

in

{
  config = mkIf enable {
    home.sessionVariables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };

    home.packages = with pkgs; [
      ag
      fzf
      my-neovim
    ];

  };
}
