{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.system.nixpkgs;
in {
  options.system.nixpkgs = {
    enable = mkEnableOption "Enable Nixpkgs Defaults";
  };

  config = mkIf cfg.enable {
    nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
    ];

    config = {
      allowUnfree = true;
    };
  };
  };
}