{ callPackage, stdenv, fennel, pkgs }:

let
  # neovim = neovim-unwrapped;
  neovim = (callPackage ./neovim-master.nix { });
  plugins = (callPackage ./plugins.nix { });
in

(callPackage ./wrapper.nix { }) neovim {
  viAlias = true;
  vimAlias = true;

  withNodeJs = false;
  withRuby = false;

  configure = {
    packages.myVimPackage = with pkgs.vimPlugins; with plugins; {
      start = [
        mysetup
        nvim-lspconfig
        vim-nix
        gruvbox
        vim-gruvbox8
        (callPackage ./parinfer-rust.nix { })
        vim-airline
        vim-airline-themes
        vim-surround
        vim-fugitive
        fzf-vim
        ranger-vim
        deol-nvim
        vimagit
        fennel-vim
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
}
