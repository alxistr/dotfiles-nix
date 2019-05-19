{ pkgs, config, lib, ... }:
with lib; with types;
{ 
  config = {
    networking.nameservers = [ "8.8.8.8" "8.8.4.4" ]; 
    time.timeZone = "Europe/Moscow";
  }; 

}
