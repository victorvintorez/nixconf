{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.system.users;
in {
  options.system.users = {
    enable = mkEnableOption "Enable Users Defaults";
    name = mkOption {
      type = types.str;
      example = "JohnDoe";
    };
    description = mkOption {
      type = types.nullOr types.str;
      example = "John Doe's account";
    };
  };
  
  config = mkIf cfg.enable {
    users = {
      defaultUserShell = pkgs.fish;
      users = {
        ${cfg.name} = {
          description = cfg.description;
          extraGroups = [
            "wheel"
            "video"
            "audio"
            "networkmanager"
            "seat"
            "adbusers"
          ];
          initialPassword = "changeMe123";
          isNormalUser = true;
          useDefaultShell = true;
        };
      };
    };

    environment = {
      sessionVariables = {
        FLAKE = "/home/${cfg.name}/nixconf";
      };
    };
    
  };
}