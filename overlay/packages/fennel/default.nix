{ stdenv, pkgs, fetchurl, fetchFromGitHub }:

let
  lua = pkgs.luajit;
  # lua = pkgs.lua5_3;

  env-lua = lua.withPackages (ps: with ps; [
    inspect
    (pkgs.lua-moses.override {
      lua = ps.lua;
      luaPackages = ps;
    })
  ]);

in

stdenv.mkDerivation {
   name = "fennel";
   version = "0.0.6";

   src = fetchFromGitHub {
     owner = "bakpakin";
     repo = "Fennel";
     rev = "03263b8bea5ccf928978920f5082e42bc69c9ad8";
     sha256 = "1sm52gph523nzjrl3nx2kw7nbx4gcridghxm1ld801wd1pskwszf";
   };

   buildInputs = [ env-lua ];

   makeFlags = [ "PREFIX=$(out)" ];

}
