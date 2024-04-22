{
    options,
    config,
    lib,
    ...
}:
with lib;
with lib.nixconf;
let
    cfg = config.system.bios.efi;
in {
    options.system.bios.efi = with types; {
        enable = mkEnableOpt;
        
    };

    config = mkIf cfg.enable {
        boot = {
            kernelPackages = pkgs.linuxPackagesFor pkgs.linux_latest;

            supportedFilesystems = [ "btrfs" "ext4" ];

            initrd = {
                supportedFilesystems = [ "btrfs" "ext4" ]
            };

            loader = {
                # 2 second timeout on bootloader
                timeout = 2;
                systemd-boot = {
                    enable = true;
                    configurationLimit = 5;
                    consoleMode = "max";
                    editor = false;
                };
                efi = {
                    canTouchEfiVariables = true;
                };
            };
        };
    };
}