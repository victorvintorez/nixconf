{
    options,
    config,
    lib,
    ...
}:
with lib;
with lib.nixconf;
let
    cfg = config.system.hardware.networking;
in {
    options.system.hardware.networking = with types; {
        enable = mkEnableOpt;
        hostname = mkOpt str "nixos" "The hostname of the system";
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