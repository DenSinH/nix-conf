{ config, pkgs, ... }:

{
  # Linux kernel version 6.12.88 seems to have issues with bluetooth
  # See for example
  # https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1136884
  # Get the currently configured kernel version with
  #
  # nix eval --raw .#nixosConfigurations.<hostname>.config.boot.kernelPackages.kernel.version
  #
  # or the latest available with
  #
  # nix eval --raw nixpkgs#linuxPackages_latest.kernel.version
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_7_0;

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
    gthumb # image viewer (previews)
    gnome-control-center # settings GUI
    dconf-editor # dconf settings
    gvfs # network mounts, trash, etc.
    gnome-keyring # secrets, ssh agent, etc.
    # video player and plugins
    totem
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-libav
    # for firefox
    ffmpeg-full
    libva
    libva-utils
    nfs-utils
  ];

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "gnome-terminal";
  };

  # NFS configuration
  services.rpcbind.enable = true;
  boot.supportedFilesystems = [ "nfs" ];

  fileSystems."/mnt/drive" = {
    device = "192.168.50.20:/mnt/primary/drive";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
    ];
  };

  # make firefox default pdf app
  xdg.mime.enable = true;
  xdg.mime.defaultApplications = {
    "application/pdf" = "firefox.desktop";
  };

  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
  };

  services.tailscale.enable = true;
}
