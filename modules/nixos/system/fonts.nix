{ inputs, outputs, lib, config, pkgs, ... }: 
with lib;
let
  cfg = config.system.fonts;
in {
  options.system.fonts = {
    enable = mkEnableOption "Enable Fonts Defaults";
  };
  
  config = mkIf cfg.enable {
    fonts = {
      enableDefaultPackages = true;

      packages = with pkgs; [
        iosevka
        (nerdfonts.override { fonts = ["Iosevka"]; })
      ];

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
  };
}