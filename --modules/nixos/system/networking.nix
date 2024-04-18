{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.system.networking;
in {
  options.system.networking = {
    enable = mkEnableOption "Enable Networking Defaults";
    hostname = mkOption {
      type = types.str;
      default = "nixos";
      description = "The hostname of the system.";
    };
  };

  config = mkIf cfg.enable {
    networking = {
      hostName = cfg.hostname;
      networkmanager = {
        enable = true;
        wifi = {
          backend = "iwd";
          powersave = false;
        };
      };
    };

    # Disable NetworkManager-wait-online and systemd-networkd-wait-online
    systemd = {
      services = {
        NetworkManager-wait-online = {
          enable = false;
        };
        systemd-networkd-wait-online = {
          enable = false;
        };
      };
    };
  };
}