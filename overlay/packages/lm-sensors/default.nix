{ pkgs, stdenv, lib, writeScriptBin }:

writeScriptBin "sensors"
  ''
    ${pkgs.lm_sensors}/bin/sensors -c ${./sensors.conf} $@
  ''
