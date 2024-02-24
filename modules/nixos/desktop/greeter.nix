{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.desktop.greeter;
in {
  options.desktop.greeter = {
    enable = mkEnableOption "Enable Greeter Defaults";
  };
  
  config = mkIf cfg.enable {
    
  };
}