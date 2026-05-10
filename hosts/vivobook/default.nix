{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./home.nix
    ../../modules/laptop/input.nix
    ./fingerprint-elan-0c90.nix
  ];

  # see
  # https://www.reddit.com/r/NixOS/comments/1fy8run/comment/lqsy3nr/
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # find with
    # nix-shell -p pciutils --run lspci
    prime = {
      sync.enable = true;

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  powerManagement.cpuFreqGovernor = "performance";

  features = {
    dev = {
      enable = true;
      docker = true;
      rdp = true;
    };
    gaming.enable = true;
    office = {
      enable = true;
      powershell = true;
    };
  };
}
