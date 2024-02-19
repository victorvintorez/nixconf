{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.system;
in {
  options.system = {
    enable = mkEnableOption "Enable General System Defaults";
  };

  config = mkIf cfg.enable {
    environment = {
      etc = lib.mapAttrs'
        (name: value: {
          name = "nix/path/${name}";
          value.source = value.flake;
        })
        config.nix.registry;
      
      systemPackages = with pkgs; [
        wget
        curl
        git
      ];
    };
  };
}