{ writeTextFile, fetchFromGitHub }:

let
  parinfer-rust-mode = fetchFromGitHub {
    rev = "v0.5.1";
    owner = "justinbarclay";
    repo = "parinfer-rust-mode";
    sha256 = "0bxi2141vx0067fcj743n55bv83wqzwvp35hg018w2nmnac3rqg8";
  };

  parinfer-rust-library-version = "0.4.0";

  parinfer-rust-library = builtins.fetchurl {
    url = "https://github.com/eraserhd/parinfer-rust/releases/download/v${parinfer-rust-library-version}/parinfer-rust-linux.so";
    sha256 = "1j8nxppy8mai1gz7738myb67nay0641l8qqqhn0rf0drvldzbx00";
  };

in

writeTextFile rec {
  name = "parinfer-rust-mode";
  destination = "/share/emacs/site-lisp/${name}.el";
  text = ''
    (setq parinfer-rust-library "${parinfer-rust-library}")
    (add-to-list 'load-path "${parinfer-rust-mode}")
    (load "parinfer-rust-mode")
  '';
}
