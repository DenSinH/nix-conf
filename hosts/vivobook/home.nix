{
  pkgs,
  config,
  lib,
  ...
}:

{
  # nvidia settings in System folder in gnome app picker
  home-manager.users.dennis.dconf.settings = {
    "org/gnome/desktop/app-folders/folders/System" = {
      apps = [ "nvidia-settings.desktop" ];
    };
  };
}
