{
    options,
    config,
    lib,
    ...
}:
with lib;
with lib.nixconf;
let
    cfg = config.system.hardware;
in {
    options.system.hardware = with types; {
        enable = mkEnableOpt;
        
    };

    config = mkIf cfg.enable {
        hardware = {
            enableAllFirmware = true;
            enableRedistributableFirmware = true;
            opengl = {
                enable = true;
                driSupport = true;
                driSupport32Bit = true;
            };
        };

        sound = {
            enable = true;
            mediaKeys = {
                enable = true;
                volume = "2.5%";
            };
        };

        services = {
            pipewire = {
                enable = true;
                alsa = {
                enable = true;
                support32Bit = true;
                };
                audio = {
                enable = true;
                };
                jack = {
                true;
                };
                pulse = {
                enable = true;
                };
                wireplumber = {
                enable = true;
                };
            };
        };

        environment.systemPackages = with pkgs; mkIf config.desktop.enable [
            pavucontrol
        ]
    };
}