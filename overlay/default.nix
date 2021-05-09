self: super:
let inherit (super) callPackage; in
{
  i3lockpp = callPackage ./packages/i3lockpp { };
  adhosts = callPackage ./packages/adhosts { };

  flat-remix = callPackage ./packages/flat-remix { };
  gruvbox-light = callPackage ./packages/gruvbox/light { };
  gruvbox-dark = callPackage ./packages/gruvbox/dark { };

  drivers = {
    dcpt310 = callPackage ./packages/dcpt310 { };
    x52pro = callPackage ./packages/x52 { };
  };

  kind = callPackage ./packages/kind { };
  ferret = callPackage ./packages/ferret { };
  babashka = callPackage ./packages/bb { };

  # fzf = callPackage ./packages/fzf { };

  my-emacs = callPackage ./packages/emacs { };
  my-neovim = callPackage ./packages/neovim { };

  arion = callPackage "${super.fetchFromGitHub {
    owner = "hercules-ci";
    repo = "arion";
    rev = "221bccd7f149a25fefce8943179ef62cb73d4313";
    sha256 = "0i02bwbyy0m382avvvkj49rhq1i2vqjgxcnvzrj345pbwqvh3xq3";
  }}/arion.nix" { };

  vivaldi = super.vivaldi.override { proprietaryCodecs = true; };

  lm-sensors = callPackage ./packages/lm-sensors { };

  powerline-rs = callPackage (import ./packages/powerline-rs).override {
    pkgs = super;
  };
  # powerline-rs = callPackage (import ./packages/powerline-rs).build {
  #   inherit (super.darwin.apple_sdk.frameworks) Security;
  #   openssl = super.openssl_1_1;
  # };

  # parinfer-rust = callPackage ./packages/parinfer-rust { };

  clojure = callPackage ./packages/clojure { };

  awesome-freedesktop = callPackage ./packages/lua-packages/awesome-freedesktop.nix { };
  lua-moses = callPackage ./packages/lua-packages/moses.nix { };

  awesomerc = callPackage ./packages/awesomerc { };
  awesomerc-debug = callPackage ./packages/awesomerc/debug.nix { };

  fennel = callPackage ./packages/fennel { };
  fennelns = callPackage ./packages/fennelns { };
  fennelns-debug = callPackage ./packages/fennelns/debug.nix { };

  bandcamp-downloader = callPackage ./packages/bandcamp-downloader { pythonPackages = self.python36Packages; };
  scdl = callPackage ./packages/scdl { pythonPackages = self.python37Packages; };
  fabric1 = callPackage ./packages/fabric1 { pythonPackages = self.python27Packages; };

  xnview = callPackage ./packages/xnview { };

  awmtt = callPackage ./packages/awmtt { };

  shell-tools = {
    liquidprompt = builtins.fetchGit {
      url = "https://github.com/nojhan/liquidprompt/";
      rev = "488bb5975db9fa8be0b795019f0b6d99ec792f50";  # v_1.11
    };
    bash-functions = callPackage ./packages/shell-tools/bash-functions.nix { };
    oom-pls = callPackage ./packages/shell-tools/oom-pls.nix { };
    dump-colors = callPackage ./packages/shell-tools/dump-colors.nix { };
    draw-in-palette = callPackage ./packages/shell-tools/draw-in-palette.nix { };
    create-docker-template = callPackage ./packages/shell-tools/create-docker-template.nix { };
    ipynb-to-py = callPackage ./packages/shell-tools/bb/ipynb-to-py.nix { };
    subs-to-chapters = callPackage ./packages/shell-tools/bb/subs-to-chapters.nix { };
    extract-subs = callPackage ./packages/shell-tools/extract-subs.nix { };
  };

  xi-editor = callPackage ({ rustPlatform, fetchFromGitHub }:
    rustPlatform.buildRustPackage rec {
      name = "xi-editor";
      src = "${fetchFromGitHub {
        owner = "xi-editor";
        repo = name;
        rev = "add9e3e2f74c1324e85d1e2208f361b435b3fe2f";
        sha256 = "1wy84a7q0gmchdklg50z3jzfbriwsd4awgqngmkq9szxxs35rhz4";
      }}/rust";
      cargoSha256 = "1bcmr6ndzj5j0jqbmi61x3dim1x5cj7rgy7r92fr8c4x9hp986wx";
  }) { };

  wallpapers = ./packages/wallpapers;

}
