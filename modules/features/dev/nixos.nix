{
  featureName,
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.features.${featureName};
in
{
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (lib.mkIf cfg.docker {
        virtualisation.docker.enable = true;

        users.users.dennis = {
          extraGroups = [ "docker" ];
        };
      })
    ]
  );
}
