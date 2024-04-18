{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.system.shell;
in {
  options.system.shell = {
    enable = mkEnableOption "Enable Shell Defaults";
  };
  
  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      vendor = {
        completions = {
          enable = true;
        };
        config = {
          enable = true;
        };
        functions = {
          enable = true;
        };
      };
    };
  };
}