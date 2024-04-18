{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.system.boot;
in {
  options.system.boot = {
    enable = mkEnableOption "Enable Boot Defaults";
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