{ callPackage, stdenv, fennel, pkgs, fetchurl,
  wrapNeovim, neovim-unwrapped }:

let
  lua = pkgs.luajit;

  mysetup = pkgs.vimUtils.buildVimPlugin {
    name = "mysetup";
    src = ./mysetup;
    postInstall = ''
      mkdir -p $target/lua/deps/
      find ${fennel} \
         -type f -name "*.lua" \
         -exec cp {} $target/lua/deps/ \;
      ${fennel}/bin/fennel --compile \
         $src/fnl/mysetup.fnl > $target/lua/mysetup.lua
    '';
  };

  fennel-vim = pkgs.vimUtils.buildVimPlugin {
    name = "fennel.vim";
    src = pkgs.fetchFromGitHub {
      owner = "bakpakin";
      repo = "fennel.vim";
      rev = "fb501756526bd61c31edd2ac8626add978435a11";
      sha256 = "0wpqgylpq45w1cfq63cch7ky2qs9rc052nhh8dhgsfsq8v26233r";
    };
  };

  neovim = neovim-unwrapped;

in

wrapNeovim neovim {
  viAlias = true;
  vimAlias = true;

  withNodeJs = false;
  withRuby = false;

  configure = {
    packages.myVimPackage = with pkgs.vimPlugins; {
      start = [
        mysetup
        vim-nix
        gruvbox
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
