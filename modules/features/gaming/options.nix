{
  featureName,
  lib,
  ...
}:

{
  options = {
    features.${featureName} = {
      enable = lib.mkEnableOption "Enable gaming features";
    };
  };
}
