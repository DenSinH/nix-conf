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
  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;

    users.users.dennis = {
      extraGroups = [ "docker" ];
    };
  };
}
