{
  featureName,
  lib,
  ...
}:

{
  options = {
    features.${featureName} = {
      enable = lib.mkEnableOption "Enable development features";

      docker = lib.mkEnableOption "Enable Docker support";
      rdp = lib.mkEnableOption "Install RDP client";
    };
  };
}
