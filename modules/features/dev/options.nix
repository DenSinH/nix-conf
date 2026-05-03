{
  featureName,
  lib,
  ...
}:

{
  options = {
    features.${featureName} = {
      enable = lib.mkEnableOption "Enable development features";
    };
  };
}
