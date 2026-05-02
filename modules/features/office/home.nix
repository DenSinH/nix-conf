{
  featureName,
  pkgs,
  lib,
  features,
  ...
}:

{
  config = lib.mkIf features.${featureName}.enable {
    home.packages = with pkgs; [
      teams-for-linux
    ];
  };
}
