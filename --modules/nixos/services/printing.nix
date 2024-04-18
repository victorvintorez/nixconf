{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.services.printing;
in {
  options.services.printing = {
    enable = mkEnableOption "Enable Printing Defaults";
  };
  
  config = mkIf cfg.enable {
    services = {
      printing = {
        enable = true;
        drivers = [
          brgenml1lpr
          brgenml1cupswrapper
        ];
      };
      avahi = {
        enable = true;
        ipv4 = true;
        ipv6 = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };
  };
}