{
    options,
    config,
    lib,
    ...
}:
with lib;
with lib.nixconf;
let
    cfg = config.system.security.sops;
in {
    options.system.security.sops = with types; {
        enable = mkEnableOpt;
    };

    config = mkIf cfg.enable {
        sops = {
            defaultSopsFile = ../../../../../secrets/secrets.yaml;
            defaultSopsFormat = "yaml";

            gnupg = {
                home = "/home/${config.user.username}/.gnupg";
                sshKeyPaths = [];
            };
        };

        home.persist.directories = [
            ".config/sops"
        ];
    };
}