{
    options,
    config,
    lib,
    ...
}:
with lib;
with lib.nixconf;
let
    cfg = config.system.nix;
in {
    options.system.nix = with types; {
        enable = mkEnableOpt;
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            nil
            nixfmt
            nix-index
            nix-prefetch-git
        ];

        nix = {
            settings = {
                experimental-features = ["nix-command" "flakes"];
                http-connections = 50;
                warn-dirty = false;
                log-lines = 50;
                sandbox = "relaxed";
                auto-optimise-store = true;
                trusted-users = [ "root" "${config.user.username}"];
                allowed-users = [ "root" "${config.user.username}"];
                keep-outputs = true;
                keep-derivations = true;
            };
            gc = {
                automatic = true;
                dates = "weekly";
                options = "--delete-older-than 7d";
            };
        };
    };
}