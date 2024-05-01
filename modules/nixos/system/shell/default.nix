{
    options,
    config,
    lib,
    ...
}:
with lib;
with lib.nixconf;
let
    cfg = config.system.shell;
in {
    options.system.shell = with types; {
        enable = mkEnableOpt;
    };

    config = mkIf cfg.enable {
        users.users.root.shell = pkgs.bashInteractive;

        environment.systemPackages = with pkgs; [
            fish
            nitch
        ];

        home.programs.nushell = {
            enable = true;
            shellAliases = config.environment.shellAliases;
            envFile.text = "";
            configFile = ./config.nu;
        };

        environment.shellAliases = {
            ".." = "cd ..";
            cat = "bat";
            neofetch = "nitch";
            rf = "rm -rf";
        };

        home.programs.eza = {
            enable = true;
            enableBashIntegration = true;
            enableFishIntegration = true;
            enableNushellIntegration = true;
            git = true;
            icons = true;
            extraOptions = [
                "--group-directories-first"
                "--hyperlink"
            ];
        };

        home.programs.bat = {
            enable = true;
        };

        home.programs.zoxide = {
            enable = true;
        };

        home.programs.carapace = {
            enable = true;
        };

        home.programs.starship = {
            enable = true;
            enableBashIntegration = true;
            enableFishIntegration = true;
            enableNushellIntegration = true;
        };

        home.persist.directories = [
            ".cache/starship"
            ".config/nushell"
            ".config/fish"
            ".local/share/zoxide"
            ".cache/zoxide"
        ];
    };
}