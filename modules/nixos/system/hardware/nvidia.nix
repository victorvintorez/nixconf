{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.system.hardware.nvidia;
in {
  options.system.hardware.nvidia = {
    enable = mkEnableOption "Enable Nvidia Defaults";
  };
  
  config = mkIf cfg.enable {
    hardware = {
      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        modesetting = {
          enable = true;
        };
        nvidiaSettings = true;
      };
    };
    services = {
      xserver = {
        videoDrivers = [ "nvidia" ];
      };
    };
  };
}