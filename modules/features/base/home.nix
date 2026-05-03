{
  pkgs,
  ...
}:

{
  programs.firefox = {
    enable = true;

    profiles.default = {
      isDefault = true;
      name = "Dennis";

      settings = {
        "extensions.autoDisableScopes" = 0;
        "extensions.enabledScopes" = 15;
      };

      # search addons here:
      # https://nur.nix-community.org/repos/rycee/
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
      ];
    };
  };

  # base features are always enabled
  dconf.settings = {
    "org/gnome/shell" = {
      # Dash menu settings
      favorite-apps = [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "code.desktop"
        "org.gnome.Terminal.desktop"
      ];
    };
    "org/gnome/gnome-session" = {
      logout-prompt = false;
    };
  };
}
