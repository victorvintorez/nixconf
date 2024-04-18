{
    options,
    config,
    lib,
    ...
}:
with lib;
with lib.nixconf;
let
    cfg = config.system.locale;
in {
    options.system.locale = with types; {
        enable = mkEnableOpt;
    };

    config = mkIf cfg.enable {
        time = {
            timeZone = "Europe/London";
        };

        i18n = {
            defaultLocale = "en_US.UTF-8";
            extraLocaleSettings = {
                LC_ADDRESS = "en_GB.UTF-8";
                LC_IDENTIFICATION = "en_GB.UTF-8";
                LC_MEASUREMENT = "en_GB.UTF-8";
                LC_MONETARY = "en_GB.UTF-8";
                LC_NAME = "en_GB.UTF-8";
                LC_NUMERIC = "en_GB.UTF-8";
                LC_PAPER = "en_GB.UTF-8";
                LC_TELEPHONE = "en_GB.UTF-8";
                LC_TIME = "en_GB.UTF-8";
            };
            inputMethod = {
                enabled = "ibus";
            };
        };

        console.useXkbConfig = true;
        services.xserver = {
            layout = "us";
        };
    };
}