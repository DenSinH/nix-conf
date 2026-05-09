{ config, pkgs, ... }:

{
  # gnome is always enabled
  services.xserver.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # https://hugosum.com/blog/customizing-gnome-with-nix-and-home-manager
  # disable built-in gnome stuff
  services.gnome.games.enable = false;
  services.gnome.core-apps.enable = false;
  environment.gnome.excludePackages = (
    with pkgs;
    [
      gnome-tour
      gnome-shell-extensions
    ]
  );

  # re-add some UX stuff
  environment.systemPackages = with pkgs; [
    nautilus
    gnome-terminal
    file-roller # archive support
    eog # image viewer (previews)
    gnome-control-center # settings GUI
    dconf-editor # dconf settings
    gvfs # network mounts, trash, etc.
    gnome-keyring # secrets, ssh agent, etc.
  ];

  environment.variables = {
    MOZ_ENABLE_WAYLAND = "0";
    MOZ_USE_XINPUT2 = "1";
  };

  services.tailscale.enable = true;
}
