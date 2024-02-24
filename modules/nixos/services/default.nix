{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.services;
in {
  imports = [
    ./printing.nix
    ./ssh.nix
  ];
  
  options.services = {
    enable = mkEnableOption "Enable Service Defaults";
  };
  
  config = mkIf cfg.enable {
    
  };
}