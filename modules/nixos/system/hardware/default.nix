{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.system.hardware;
in {
  imports = [
    ./nvidia.nix
  ];
  
  options.system.hardware = {
    enable = mkEnableOption "Enable Hardware Defaults";
  };

  config = mkIf cfg.enable {
    hardware = {
      enableAllFirmware = true;
      enableRedistributableFirmware = true;
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
    };

    sound = {
      enable = true;
      mediaKeys = {
        enable = true;
        volume = "1%";
      };
    };
  };
}