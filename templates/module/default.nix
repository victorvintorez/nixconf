{
    options,
    config,
    lib,
    ...
}:
with lib;
with lib.nixconf;
let
    cfg = config.module;
in {
    options.module = with types; {
        enable = mkEnableOpt;

    };

    config =
        mkIf cfg.enable {

    };
}