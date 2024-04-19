{ config, pkgs, lib, ... }:
{
  options = {};
  config = {
    boot.kernel.sysctl = {
      "kernel.perf_event_paranoid" = 1;
      "kernel.kptr_restrict" = 0;
    };
  };
}
