{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.desktop.greeter;
in {
  options.desktop.greeter = {
    enable = mkEnableOption "Enable Greeter Defaults";
    autoSuspend = mkOption {
      type = types.bool;
      default = false;
    };
    autoLogin = mkOption {
      type = types.bool;
      default = true;
    };
  };
  
  config = mkIf cfg.enable {
    services = {
      xserver = {
        displayManager = {
          defaultSession = "Hyprland";
          gdm = {
            enable = true;
            autoSuspend = cfg.autoSuspend;
            wayland = true;
          };
          autoLogin = mkIf cfg.autoLogin {
              enable = true;
              user = config.system.users.name;
            };
        };
      };
    };
  };
}