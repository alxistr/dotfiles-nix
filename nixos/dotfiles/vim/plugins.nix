{ pkgs, ... }:
let inherit (pkgs.vimUtils) buildVimPluginFrom2Nix; in
let inherit (builtins) fetchTarball; in
let plugin = {name, url, version ? ""}: buildVimPluginFrom2Nix {
  pname = name;
  inherit version;
  src = fetchTarball url;
}; in
{
  fzf = plugin {
    name = "fzf";
    version = "0.18.0";
    url = "https://github.com/junegunn/fzf/archive/0.18.0.tar.gz";
  };

  jellybeans = plugin {
    name = "jellybeans";
    version = "1.6";
    url = "https://github.com/nanotech/jellybeans.vim/archive/v1.6.tar.gz";
  };

  vimagit = plugin {
    name = "vimagit";
    version = "1.7.3";
    url = "https://github.com/jreybert/vimagit/archive/1.7.3.tar.gz";
  };

  vim-sexp = plugin {
    name = "vim-sexp";
    url = "https://github.com/guns/vim-sexp/tarball/12292941903d9ac8151513189d2007e1ccfc95f0";
  };

  vim-clojure-static = plugin {
    name = "vim-clojure-static";
    version = "011";
    url = "https://github.com/guns/vim-clojure-static/archive/vim-release-011.tar.gz";
  };

  vim-fish = plugin {
    name = "vim-fish";
    url = "https://github.com/dag/vim-fish/tarball/50b95cbbcd09c046121367d49039710e9dc9c15f";
  };

}
