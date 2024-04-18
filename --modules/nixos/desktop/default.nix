{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.desktop;
in {
  imports = [
    ./greeter.nix
  ];

  options.desktop = {
    enable = mkEnableOption "Enable Desktop Defaults";
  };
  
  config = mkIf cfg.enable {
    
  };
}