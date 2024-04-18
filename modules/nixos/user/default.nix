{
    options,
    config,
    lib,
    ...
}:
with lib;
with lib.nixconf;
let
    cfg = config.user;
in {
    options.user = with types; {
       username = mkOpt str "victorv" "The Username for the default user";
       initialPassword = mkOpt str "Password123" "The initial password to set for the user";
       extraGroups = mkOpt (listOf str) [] "Extra groups to assign to the user";
       extraOptions = mkOpt attrs {} "Extra options to pass to <option>users.users.<name></option>";
    };

    config = {
        users = {
            defaultUserShell = pkgs.nushell;
            mutableUsers = false;
            users.${cfg.name} = {
                description = "The user account for ${cfg.username}";
                group = "users";
                extraGroups = [
                    "wheel"
                    "video"
                    "audio"
                    "sound"
                    "seat"
                    "input"
                    "networkmanager"
                    "tty"
                ] ++ cfg.extraGroups;
                initialPassword = initialPassword;
                isNormalUser = true;
                useDefaultShell = true;
                home = "/home/${cfg.username}";
            } // cfg.extraOptions;
        };

        environment.sessionVariables.FLAKE = "/home/${cfg.name}/nixconf";

        home.persist.directories = [
            "Documents"
            "Downloads"
            "Music"
            "Pictures"
            "Videos"
            "Development"
            "nixconf"
        ];
    };
}