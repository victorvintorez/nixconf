{
    options,
    config,
    lib,
    ...
}:
with lib;
with lib.nixconf;
let
    cfg = config.system.hardware.nvidia;
in {
    options.system.hardware.nvidia = with types; {
        enable = mkEnableOpt;
        
    };

    config = mkIf cfg.enable {
        hardware = {
            nvidia = {
                package = config.boot.kernelPackages.nvidiaPackages.stable;
                modesetting = {
                    enable = true;
                };
                nvidiaSettings = true;
            };
        };
        services = {
            xserver = {
                videoDrivers = [ "nvidia" ];
            };
        };

        environment = {
            variables = {
                CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
            };
            shellAliases = {
                nvidia-settings = "nvidia-settings --config='$XDG_CONFIG_HOME/nvidia/settings";
            };
            sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
        };
    };
}