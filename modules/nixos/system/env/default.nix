{
    options,
    config,
    lib,
    ...
}:
with lib;
with lib.nixconf;
let
    cfg = config.system.env;
in {
    options.system.env = with types; {
        enable = mkEnableOpt;
    };

    config = mkIf cfg.enable {
        environment = {
            sessionVariables = {
                XDG_CACHE_HOME = "$HOME/.cache";
                XDG_CONFIG_HOME = "$HOME/.config";
                XDG_DATA_HOME = "$HOME/.local/share";
                XDG_BIN_HOME = "$HOME/.local/bin";
                # To prevent firefox from creating ~/Desktop.
                XDG_DESKTOP_DIR = "$HOME";
            };
            variables = {
                LESSHISTFILE = "$XDG_CACHE_HOME/less.history";
                WGETRC = "$XDG_CONFIG_HOME/wgetrc";
            };

            systemPackages = with pkgs; [
                wget
                curl
                git
            ];
        };
    };
}