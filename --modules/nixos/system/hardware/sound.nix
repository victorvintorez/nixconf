{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.system.hardware.sound;
in {
  options.system.hardware.sound = {
    enable = mkEnableOption "Enable Sound Defaults";
  };
  
  config = mkIf cfg.enable {
    services = {
      pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        audio = {
          enable = true;
        };
        jack = {
          true;
        };
        pulse = {
          enable = true;
        };
        wireplumber = {
          enable = true;
        };
      };
    };

    environment.systemPackages = with pkgs; mkIf config.desktop.enable [
       pavucontrol
    ];
  };
}