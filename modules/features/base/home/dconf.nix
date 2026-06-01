{
  ...
}:

{
  # dconf settings
  dconf.settings = {
    "org/gnome/shell" = {
      # Dash menu settings
      favorite-apps = [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "code.desktop"
        "org.gnome.Terminal.desktop"
      ];
      enabled-extensions = [
        # app indicators (needed for tailscale)
        "appindicatorsupport@rgcjonas.gmail.com"
      ];
    };
    "org/gnome/gnome-session" = {
      logout-prompt = false;
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    # keybinds
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-left = [ ];
      switch-to-workspace-right = [ ];
    };
    # enable minimize / maximize buttons
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };
    # auto trash after 30 days
    "org/gnome/desktop/privacy" = {
      remove-old-trash-files = true;
      trash-auto-delete-age = 30;
    };
    # background
    "org/gnome/desktop/background" = {
      picture-uri = "file://${./trumpet.jpg}";
      picture-uri-dark = "file://${./trumpet.jpg}";
      picture-options = "zoom";
    };

    # find app names with
    # ls /run/current-system/sw/share/applications
    # or by looking for the shortcut name with
    # grep -Ril "Shortcut Name" /run/current-system/sw/share/applications/
    # or by going to
    # org/gnome/shell/app-picker-layout
    # in the dconf editor
    "org/gnome/desktop/app-folders" = {
      folder-children = [ "System" ];
    };

    "org/gnome/desktop/app-folders/folders/System" = {
      name = "System";
      apps = [
        # these apps created shortcuts by default
        # most of these, I will likely never use, but I just
        # wanted to group them and hide them away somewhere
        "cups.desktop" # Manage Printing
        "htop.desktop"
        "ca.desrt.dconf-editor.desktop"
        "xterm.desktop"
        "org.gnome.FileRoller.desktop"
        "org.gnome.eog.desktop"
        "org.gnome.Extensions.desktop"
        "nixos-manual.desktop"
      ];
    };
  };
}
