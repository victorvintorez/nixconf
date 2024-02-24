{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.system.nix;
in {
  options.system.nix = {
    enable = mkEnableOption "Enable Nix Defaults";
  };

  config = mkIf cfg.enable {
    nix = {
      registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

      nixPath = ["/etc/nix/path"];
      
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 1w";
      };
    };
      environment = {
    systemPackages = with pkgs; [
      nil
      nixfmt
      nix-index
    ];
  };
  };
}