{ config, pkgs, lib, ... }:
{
  config = {
    boot.kernel.sysctl = {
      "vm.oom_kill_allocating_task" = true;
    };
  };
}
