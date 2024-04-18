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
        
    };
}