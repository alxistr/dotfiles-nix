{ stdenv, callPackage, symlinkJoin,
  fennel, vimPlugins, wrapNeovim,
  rnix-lsp, clojure-lsp,
  nightly ? true }:

let
  wrap = if ! nightly then wrapNeovim else (callPackage ./wrapper.nix { });
  neovim = (callPackage ./neovim.nix {
    inherit nightly;
  });
  plugins = (callPackage ./plugins.nix { });

  lang-servers = [
    rnix-lsp
    clojure-lsp
  ];

  wrapped-neovim = (wrap neovim {
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

          nvim-lspconfig
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

symlinkJoin {
  name = "${wrapped-neovim.name}-with-ls";
  paths = [ wrapped-neovim ] ++ lang-servers;
}
