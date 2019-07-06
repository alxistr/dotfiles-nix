{ pkgs, lib, ... }:

with lib;
let inherit (pkgs.vimUtils) buildVimPluginFrom2Nix; in
let inherit (pkgs) fetchFromGitHub fetchFromGitLab; in

let plugin = attrs@{name, src, ...}: buildVimPluginFrom2Nix (attrs // {
  pname = name;
  inherit src;
}); in

{
  fzf = plugin {
    name = "fzf";
    src = fetchFromGitHub {
      owner = "junegunn";
      repo = "fzf";
      rev = "ff951341c993ed84ad65344e496e122ee3dddf67";  # 0.18.0
      sha256 = "0pwpr4fpw56yzzkcabzzgbgwraaxmp7xzzmap7w1xsrkbj7dl2xl";
    };
  };

  fennel-vim = plugin {
    name = "fennel-vim";
    src = fetchFromGitHub {
      owner = "bakpakin";
      repo = "fennel.vim";
      rev = "17f4b3b6ac58a396bd809e69d9a5a23de53218ab";
      sha256 = "01xrch94cdcg7wy0mch090h8slypwvxrd128znz7ng5s0kcd2y0m";
    };
  };

  jellybeans = plugin {
    name = "jellybeans";
    src = fetchFromGitHub {
      owner = "nanotech";
      repo = "jellybeans.vim";
      rev = "fd089ca8a242263f61ae7bddce55a007d535bc65";  # v1.6
      sha256 = "00knmhmfw9d04p076cy0k5hglk7ly36biai8p9b6l9762irhzypp";
    };
  };

  vimagit = plugin {
    name = "vimagit";
    src = fetchFromGitHub {
      owner = "jreybert";
      repo = "vimagit";
      rev = "91b947cceb7f1c7d005f6b1941478802c4b096db";  # 1.7.3
      sha256 = "0i13d6q6s05qn6wr0jy4jsrcxwi3vwriahx5sl79wpwn43mjpdfg";
    };
  };

  vim-sexp = plugin {
    name = "vim-sexp";
    src = fetchFromGitHub {
      owner = "guns";
      repo = "vim-sexp";
      rev = "12292941903d9ac8151513189d2007e1ccfc95f0";
      sha256 = "1mfqbmrbqgnsc34pmcsrc0c5zvgxhhnw4hx4g5wbssfk1ddyx6y0";
    };
  };

  vim-clojure-static = plugin {
    name = "vim-clojure-static";
    src = fetchFromGitHub {
      owner = "guns";
      repo = "vim-clojure-static";
      rev = "33e7e1e57277bfdc33897ab2c36e8958fc214977";  # vim-release-011
      sha256 = "1993pyv3kadqxbdqiz55sk3rggpvvwf62kcikl3sy5fj9jd13bxz";
    };
  };

  vim-iced = plugin {
    name = "vim-iced";
    src = fetchFromGitHub {
      owner = "liquidz";
      repo = "vim-iced";
      rev = "e9957b2e9889ce09edfe51bb6d547a7ef97b9ec6";
      sha256 = "0000000000000000000000000000000000000000000000000000";
    };
  };

  vim-fish = plugin {
    name = "vim-fish";
    src = fetchFromGitHub {
      owner = "dag";
      repo = "vim-fish";
      rev = "50b95cbbcd09c046121367d49039710e9dc9c15f";
      sha256 = "0000000000000000000000000000000000000000000000000000";
    };
  };

  vim-hy = plugin {
    name = "vim-hy";
    src = fetchFromGitHub {
      owner = "hylang";
      repo = "vim-hy";
      rev = "944561b462d5fac75eda191faaf06a4484a16d7b";
      sha256 = "17647vw1259ky3s5vspwmpxz9vynrz034blcl6ckq9ampky76dp2";
    };
    postInstall = ''
      rm -r $target/indent
    '';
  };

  repl-nvim = plugin rec {
    name = "repl-nvim";
    src = fetchFromGitLab {
      owner = "HiPhish";
      repo = "repl.nvim";
      rev = "d99ea4260f84b7acf8d8985421af929ff2bff680";
      sha256 = "0f5z2b9grbm7kig7kxavf1js7z3pjjxrbqawp8m9062v9h4a4697";
    };
    patches = [
      ./repl-nvim.patch
    ];
  };

  iron-nvim = plugin rec {
    name = "iron-nvim";
    src = fetchFromGitHub {
      owner = "Vigemus";
      repo = "iron.nvim";
      rev = "0247b2fa12461cd5635796ad72c5ec014e971c51";
      sha256 = "0g57845z0vxdfz0la6p9003p3n1b8mhbmks7yji5p93wfpv2bk89";
    };
  };

  coc-nvim = plugin rec {
    name = "coc.nvim";
    src = fetchFromGitHub {
      owner = "neoclide";
      repo = "coc.nvim";
      rev = "99537d3c524e567ec343a01ffd2bd0aaf9605a4b";
      sha256 = "0jnz8yvfxkap891q5jwv6ndskdw992amrjls6d2gdnn2mvy0fw2l";
    };
    bundle = "https://raw.githubusercontent.com/neoclide/coc.nvim/release/index.js";
    postInstall = ''
      mkdir -p $target/build
      cp ${builtins.fetchurl bundle} $target/build/index.js
      ls -l $target
    '';
  };

}
