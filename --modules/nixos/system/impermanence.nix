{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.system.impermanence;
in {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];
  options.system.impermanence = {
    enable = mkEnableOption "Enable Impermancence";
  };
  
  config = mkIf cfg.enable {
    
  };
}