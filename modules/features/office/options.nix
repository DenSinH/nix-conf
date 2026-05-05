{
  featureName,
  lib,
  ...
}:

{
  options = {
    features.${featureName} = {
      enable = lib.mkEnableOption "Enable office features";
      powershell = lib.mkEnableOption "Install PowerShell";
    };
  };
}
