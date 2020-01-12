{ pkgs, fetchurl, writeScriptBin }:

let jar = fetchurl {
  url = "https://ferret-lang.org/builds/ferret.jar";
  sha256 = "1q9q9hpcinylgvky26f713s0y73kv4lycnbkwdcwa3c3ziidfqcg"; 
}; in 

writeScriptBin "ferret" 
 ''
   ${pkgs.jdk}/bin/java -jar "${jar}" $@ 
 ''
