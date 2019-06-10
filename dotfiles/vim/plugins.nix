{ pkgs, lib, ... }:
with lib;
let inherit (pkgs.vimUtils) buildVimPluginFrom2Nix; in
let inherit (builtins) fetchGit; in
let valueOrEmpty = value: if builtins.isNull value then "" else value; in
let plugin = attrs@{name, url, rev ? null, ref ? null, ...}: buildVimPluginFrom2Nix (attrs // {
  pname = name;
  src = fetchGit (filterAttrs (n: v: v != null) {
    inherit url rev ref;
  });
  version = "${valueOrEmpty rev}${valueOrEmpty ref}";
}); in
{
  fzf = plugin {
    name = "fzf";
    url = "https://github.com/junegunn/fzf/";
    rev = "ff951341c993ed84ad65344e496e122ee3dddf67";  # 0.18.0
  };

  jellybeans = plugin {
    name = "jellybeans";
    url = "https://github.com/nanotech/jellybeans.vim/";
    rev = "fd089ca8a242263f61ae7bddce55a007d535bc65";  # v1.6
  };

  vimagit = plugin {
    name = "vimagit";
    url = "https://github.com/jreybert/vimagit/";
    rev = "91b947cceb7f1c7d005f6b1941478802c4b096db";  # 1.7.3
  };

  vim-sexp = plugin {
    name = "vim-sexp";
    url = "https://github.com/guns/vim-sexp/";
    rev = "12292941903d9ac8151513189d2007e1ccfc95f0";
  };

  vim-clojure-static = plugin {
    name = "vim-clojure-static";
    url = "https://github.com/guns/vim-clojure-static/";
    rev = "33e7e1e57277bfdc33897ab2c36e8958fc214977";  # vim-release-011
  };

  vim-fish = plugin {
    name = "vim-fish";
    url = "https://github.com/dag/vim-fish/";
    rev = "50b95cbbcd09c046121367d49039710e9dc9c15f";
  };

  vim-hy = plugin {
    name = "vim-hy";
    url = "https://github.com/hylang/vim-hy";
    rev = "944561b462d5fac75eda191faaf06a4484a16d7b";
    postInstall = ''
      ls -l $target
      rm -r $target/indent
    '';
  };

}
