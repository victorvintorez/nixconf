{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.services.ssh;
in {
  options.services.ssh = {
    enable = mkEnableOption "Enable SSH Defaults";
  };
  
  config = mkIf cfg.enable {
    services = {
      openssh = {
        enable = true;
        allowSFTP = true;
        openFirewall = true;
        startWhenNeeded = true;
        settings = {
          KbdInteractiveAuthentication = false;
          PasswordAuthentication = false;
          PermitRootLogin = "no";
          X11Forwarding = false;
        };
      };
    };
  };
}