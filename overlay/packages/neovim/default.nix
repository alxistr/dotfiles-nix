{ callPackage, stdenv, fennel, vimPlugins, wrapNeovim,
  nightly ? false }:

let
  wrap = if ! nightly then wrapNeovim else (callPackage ./wrapper.nix { });
  neovim = (callPackage ./neovim.nix {
    inherit nightly;
  });
  plugins = (callPackage ./plugins.nix { });

in

wrap neovim {
  viAlias = true;
  vimAlias = true;

  withNodeJs = false;
  withRuby = false;

  configure = {
    packages.myVimPackage = with vimPlugins; with plugins; {
      start = [
        mysetup
        vim-nix
        gruvbox
        vim-gruvbox8
        (callPackage ./parinfer-rust.nix { })
        vim-airline
        vim-airline-themes
        vim-surround
        vim-fugitive
        vim-gitgutter
        fzf-vim
        ranger-vim
        deol-nvim
        vimagit
        fennel-vim
        LanguageClient-neovim
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
