self: super:
let inherit (super) callPackage; in
{
  adhosts = callPackage ./packages/adhosts { };

  awesomerc = callPackage ./packages/awesomerc { };
  awesomerc-debug = callPackage ./packages/awesomerc/debug.nix { };
  awesome-freedesktop = callPackage ./packages/lua-packages/awesome-freedesktop.nix { };
  lua-moses = callPackage ./packages/lua-packages/moses.nix { };
  i3lockpp = callPackage ./packages/i3lockpp { };
  awmtt = callPackage ./packages/awmtt { };
  flat-remix = callPackage ./packages/flat-remix { };
  gruvbox-light = callPackage ./packages/gruvbox/light { };
  gruvbox-dark = callPackage ./packages/gruvbox/dark { };
  wallpapers = ./packages/wallpapers;

  shen = callPackage ./packages/shen { };
  gdx-liftoff = callPackage ./packages/gdx-liftoff { };
  ferret = callPackage ./packages/ferret { };
  fennel = callPackage ./packages/fennel { };
  fennelns = callPackage ./packages/fennelns { };
  fennelns-debug = callPackage ./packages/fennelns/debug.nix { };

  bandcamp-downloader = callPackage ./packages/bandcamp-downloader { pythonPackages = self.python36Packages; };
  scdl = callPackage ./packages/scdl { pythonPackages = self.python37Packages; };
  fabric1 = callPackage ./packages/fabric1 { pythonPackages = self.python27Packages; };

  xact = callPackage ./packages/xact { pythonPackages = self.python37Packages; };

  drivers = {
    dcpt310 = callPackage ./packages/dcpt310 { };
    x52pro = callPackage ./packages/x52 { };
  };

  # java-jmc = callPackage ./packages/java-jmc { };

  my-emacs = callPackage ./packages/emacs { };
  # j = callPackage ./packages/j { };
  j = super.j.overrideAttrs (oldAttrs: {
    NIX_CFLAGS_COMPILE = "-Wno-error=deprecated-non-prototype";
  });

  # kind = callPackage ./packages/kind { };
  arion = callPackage "${super.fetchFromGitHub {
    owner = "hercules-ci";
    repo = "arion";
    rev = "221bccd7f149a25fefce8943179ef62cb73d4313";
    sha256 = "0i02bwbyy0m382avvvkj49rhq1i2vqjgxcnvzrj345pbwqvh3xq3";
  }}/arion.nix" { };

  xnview = callPackage ./packages/xnview { };

  shell-tools = {
    lm-sensors = callPackage ./packages/lm-sensors { };
    bash-functions = callPackage ./packages/shell-tools/bash-functions.nix { };
    inotify-watch = callPackage ./packages/shell-tools/inotify-watch.nix { };
    oom-pls = callPackage ./packages/shell-tools/oom-pls.nix { };
    dump-colors = callPackage ./packages/shell-tools/dump-colors.nix { };
    draw-in-palette = callPackage ./packages/shell-tools/draw-in-palette.nix { };
    create-docker-template = callPackage ./packages/shell-tools/create-docker-template.nix { };
    create-androidenv-shell = callPackage ./packages/shell-tools/create-androidenv-shell.nix { };
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

}
