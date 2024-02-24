{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.desktop.hyprland;
in {
  options.desktop.hyprland = {
    enable = mkEnableOption "Enable Hyprland Defaults";
  };
  
  config = mkIf cfg.enable {
    
  };
}