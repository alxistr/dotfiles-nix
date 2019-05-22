{ config, pkgs, lib, ... }:
with lib; with types;
{ 
  options.own.shell = mkOption{
    type = enum [
      "bash"
      "fish"
    ]; 
    default = "bash";
  };

  config = mkIf (config.own.shell == "fish") {
    programs.fish.enable = true;
    users.users = with pkgs; {
      root.shell = fish;
      user.shell = fish;
    }; 
  };

} 
