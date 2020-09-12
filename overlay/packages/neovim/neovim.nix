{ pkgs, neovim-unwrapped,
  nightly ? false }:

if ! nightly then
  neovim-unwrapped
else
  neovim-unwrapped.overrideAttrs (oldAttrs: {
    pname = "neovim-nightly";
    version = "master";
    src = pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "aa4557920696c45335f42f03e7b23b7038b5864e";
      sha256 = "1k1glwp8mnslnfh2fyv54dyyv9ng12fhxjslfwgjv2d6ndrwmfq5";
    };
    patches = [ ];
  })
