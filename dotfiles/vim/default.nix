{ config, pkgs, lib, ... }:
let enabled = config.nixos-config.own.gui.enable; in
let plugins = import ./plugins.nix {inherit pkgs;}; in
with lib; with types;
{
  config = mkIf enabled {
    home.packages = with pkgs; [
      ag
      fzf
    ];

    programs = {
      neovim = {
        enable = true;
        vimAlias = true;

        configure = {
          customRC = builtins.readFile ./rc.vim;

          packages.myVimPackage = with pkgs.vimPlugins; {
            # loaded on launch
            start = [
              vim-colorschemes
              vim-airline
              vim-airline-themes
              base16-vim
              plugins.jellybeans

              fzf-vim
              plugins.fzf

              ranger-vim
              deol-nvim

              plugins.vimagit
              vim-fugitive
              vim-gitgutter

              vim-surround

              deoplete-nvim
              deoplete-jedi
              jedi-vim

              plugins.vim-sexp
              vim-parinfer  # https://github.com/eraserhd/parinfer-rust
              vim-fireplace
              plugins.vim-clojure-static

              vim-nix
              plugins.vim-fish

            ];

            # manually loadable by calling `:packadd $plugin-name`
            opt = [ ];

          };

        };

      };

    };

  };

}
