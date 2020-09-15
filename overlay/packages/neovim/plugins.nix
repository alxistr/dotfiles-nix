{ pkgs, fennel }:
{
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

  vim-gruvbox8 = pkgs.vimUtils.buildVimPlugin {
    name = "vim-gruvbox8";
    src = pkgs.fetchFromGitHub {
      owner = "lifepillar";
      repo = "vim-gruvbox8";
      rev = "ba5d9bc5fea31a3b0c0e1c47aa6e4421fcdf0132";
      sha256 = "0yc2fvy6j2x3wginkwrbgg75514h8y83lhw0chn2xh1h7af7zvw4";
    };
  };

  nvim-lspconfig = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-lspconfig";
    src = pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "nvim-lspconfig";
      rev = "60133c47e0fd82556d7ca092546ebfa8d047466e";
      sha256 = "15ysbbvxlgy1qx8rjv2i9pgjshldcs3m1ff0my2y5mnr3cpqb3s6";
    };
    buildPhase = ":";
  };

  completion-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "completion-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-lua";
      repo = "completion-nvim";
      rev = "92f26db4233aff7c61b7f48c63e6f3d82183208b";
      sha256 = "0k8dl72f3w9dvvb51abr23j2cjd80hp918m16133n5mdqihn7v80";
    };
  };

}
