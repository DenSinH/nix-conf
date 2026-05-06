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
    # if you need to update this, find the file at
    # ~/.config/libreoffice/4/user/registrymodifications.xcu
    xdg.configFile."libreoffice/4/user/registrymodifications.xcu".source = ./libreoffice-config.xcu;

    programs.thunderbird = {
      enable = true;

      profiles.default = {
        isDefault = true;
      };
    };

    dconf.settings = {
      "org/gnome/desktop/app-folders" = {
        folder-children = [ "Office" ];
      };

      "org/gnome/desktop/app-folders/folders/Office" = {
        name = "Office";
        apps = [
          "thunderbird.desktop"
          "teams-for-linux.desktop"
          "writer.desktop"
          "impress.desktop"
          "draw.desktop"
          "math.desktop"
          "calc.desktop"
          "base.desktop"
          "startcenter.desktop"
        ];
      };
    };
  };
}
