{ stdenv, pkgs, fetchurl, fetchFromGitHub }:

let
  lua = pkgs.luajit;
  # lua = pkgs.lua5_3;

  env-lua = lua.withPackages (ps: with ps; [
    inspect
  ]);

in

stdenv.mkDerivation {
   name = "fennel";

   src = fetchFromGitHub {
     owner = "bakpakin";
     repo = "Fennel";
     rev = "336b0ecbda38c26d8bc68820748376f2f0e3a99a";
     sha256 = "12555nnqph3f3gfvfc314dgisr11xf4nhx7wdgwfvwvmmvia4aq0";
   };

   buildInputs = [ env-lua ];

   makeFlags = [ "PREFIX=$(out)" ];

}
