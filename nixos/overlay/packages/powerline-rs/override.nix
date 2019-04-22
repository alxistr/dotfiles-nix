{ stdenv, lib, pkgs, fetchFromGitLab }:
pkgs.powerline-rs.overrideAttrs (oldAttrs: rec {
  pname = "powerline-rs";
  name = "${pname}-${version}";
  version = "0.1.9+1b7e39ed"; 
  src = fetchFromGitLab {
    owner = "jD91mZM2";
    repo = "powerline-rs";
    rev = "1b7e39ed1f0a65d172288121569430e0ab467536"; 
    sha256 = "0fx6dr1rwz2kfvz63knbaqkvwbzzl3q9xcdzzqs0dw2a7293birb";
  }; 
  cargoSha256 = "1sr9vbfk5bb3n0lv93y19in1clyvbj0w3p1gmp4sbw8lx84zwxhc"; 
})
