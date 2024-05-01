{
    options,
    config,
    lib,
    ...
}:
with lib;
with lib.nixconf;
let
    cfg = config.system.hardware.battery;
in {
    options.system.hardware.battery = with types; {
        enable = mkEnableOpt;
        
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