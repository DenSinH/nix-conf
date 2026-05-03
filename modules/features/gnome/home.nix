{
  ...
}:

{
  # gnome is always enabled
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
