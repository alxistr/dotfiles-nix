{ config, pkgs, lib, ... }:

let enable = config.nixos-config.own.neovim; in
let plugins = import ./plugins.nix {inherit pkgs lib;}; in
with lib; with types;

{
  config = {
    home.packages = with pkgs; [
      ag
      fzf
    ];

    home.sessionVariables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };

    programs.vim = mkIf (!enable) {
      enable = true;
    };

    programs.neovim = mkIf enable {
      enable = true;
      vimAlias = true;

      withNodeJs = false;
      withRuby = false;

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

            nerdcommenter

            fzf-vim
            plugins.fzf

            ranger-vim
            deol-nvim

            plugins.vimagit
            vim-fugitive
            vim-gitgutter

            vim-surround

            deoplete-nvim
            # deoplete-jedi
            # jedi-vim
            plugins.vim-hy

            # plugins.coc-nvim

            # plugins.repl-nvim
            plugins.iron-nvim

            plugins.vim-sexp
            vim-parinfer  # https://github.com/eraserhd/parinfer-rust
            vim-fireplace
            plugins.vim-clojure-static
            # plugins.vim-iced

            vim-nix

            # plugins.vim-fish

          ];

          # manually loadable by calling `:packadd $plugin-name`
          opt = [ ];

        };

      };

    };

  };

}
