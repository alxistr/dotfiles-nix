{ config, pkgs, lib, ... }:
let cfg = config.own.oom; in
with lib; with types;
{
  options.own.oom = {
    enable = mkOption {
      default = false;
      type = bool;
    };
    overcommit = mkOption {
      default = false;
      type = bool;
    };
    earlyoom = mkOption {
      default = true;
      type = bool;
    };
  };

  config = mkIf cfg.enable {
    boot.kernel.sysctl = {
      "vm.oom_kill_allocating_task" = true;
    } // (if !cfg.overcommit then {
        "vm.overcommit_memory" = 0;
        "vm.overcommit_ratio" = 50;
    } else {
        "vm.overcommit_memory" = 2;
        "vm.overcommit_ratio" = 100;
    });

    services.earlyoom = mkIf cfg.earlyoom {
      enable = true;
      freeMemThreshold = 5;
      useKernelOOMKiller = true;
    };

  };

}
