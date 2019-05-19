{ config, pkgs, lib, ... }:
{
  config = { 
    nixpkgs.config.allowUnfree = true; 
    nixpkgs.overlays = [
      ( import ../../overlay ) 
    ]; 
  }; 
}
