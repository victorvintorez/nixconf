{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.system.powermgmt;
in {
  options.system.powermgmt = {
    enable = mkEnableOption "Enable Power Management Defaults";
    enableThermald = mkOption {
      type = types.bool;
      default = false;
    }
  };
  
  config = mkIf cfg.enable {
    services = {
      tlp = {
        enable = true;
        settings = {
          CPU_BOOST_ON_AC = 1;
          CPU_BOOST_ON_BAT = 0;
          CPU_SCALING_GOVERNER_ON_AC = "perfomance";
          CPU_SCALING_GOVERNER_ON_BAT = "powersave";
        };
      };
      power-profiles-daemon = {
        enable = false;
      };
      thermald = {
        enable = cfg.enableThermald;
      };
    };
    powerManagement = {
      powertop = {
        enable = true;
      };
    };
  };
}