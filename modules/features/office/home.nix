{
  featureName,
  pkgs,
  lib,
  features,
  ...
}:

{
  config = lib.mkIf features.${featureName}.enable {
    home.packages =
      with pkgs;
      [
        teams-for-linux
        libreoffice
      ]
      ++ lib.optional (features.${featureName}.powershell) powershell;

    programs.thunderbird = {
      enable = true;

      profiles.default = {
        isDefault = true;
      };
    };
  };
}
