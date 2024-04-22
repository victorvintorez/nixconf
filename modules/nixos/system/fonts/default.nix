{
    options,
    config,
    lib,
    ...
}:
with lib;
with lib.nixconf;
let
    cfg = config.system.fonts;
in {
    options.system.fonts = with types; {
        enable = mkEnableOpt;
        fonts = mkOpt (listOf package) [] "Custom font packages to install.";
    };

    config = mkIf cfg.enable {
        fonts = {
            enableDefaultPackages = true;

            packages = with pkgs; [
                iosevka
                (nerdfonts.override { fonts = ["Iosevka"]; })
            ] ++ cfg.extraFonts;

            fontconfig = {
                enabled = true;
                cache32Bit = true;
                defaultFonts = {
                    monospace = [
                        "DejaVu Sans Mono"
                        "Iosevka"
                    ];
                    sansSerif = [
                        "DejaVu Sans"
                        "Iosevka Aile"
                    ];
                    serif = [
                        "DejaVu Serif"
                        "Iosevka Etoile"
                    ];
                };
            };
        };

        environment = {
            variables = {
                LOG_ICONS = "true";
            };
        };
    };
}