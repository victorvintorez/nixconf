{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.system;
in {
  imports = [
    ./boot.nix
    ./fonts.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./nixpkgs.nix
    ./powermgmt.nix
    ./users.nix
    ./hardware
  ];

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