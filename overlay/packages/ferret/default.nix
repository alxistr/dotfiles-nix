{ pkgs, fetchurl, writeScriptBin }:

let jar = fetchurl {
  url = "https://ferret-lang.org/builds/ferret.jar";
  sha256 = "1xs7k1w9j5l23k7hn0zz109wxb71x9qis407cayg0jr7c30ypp48"; 
}; in 

writeScriptBin "ferret" 
 ''
   ${pkgs.jdk}/bin/java -jar "${jar}" $@ 
 ''
