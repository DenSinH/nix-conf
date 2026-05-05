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

      # libreoffice config
      xdg.configFile."libreoffice/4/user/registrymodifications.xcu".source =
        ./libreoffice-config.xcu;

    programs.thunderbird = {
      enable = true;

      profiles.default = {
        isDefault = true;
      };
    };
  };
}
