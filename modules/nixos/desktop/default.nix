{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.desktop;
in {
  options.desktop = {
    enable = mkEnableOption "Enable Desktop Defaults";
  };
  
  config = mkIf cfg.enable {
    
  };
}