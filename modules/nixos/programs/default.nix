{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.programs;
in {
  options.programs = {
    enable = mkEnableOption "Enable Program Defaults";
  };
  
  config = mkIf cfg.enable {
    
  };
}