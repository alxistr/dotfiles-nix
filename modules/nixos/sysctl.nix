{ config, pkgs, lib, ... }:
{
  config = {
    boot.kernel.sysctl = {
      "vm.oom_kill_allocating_task" = true;
      "vm.overcommit_memory" = 2;
      "vm.overcommit_ratio" = 100;
    };
  };
}
