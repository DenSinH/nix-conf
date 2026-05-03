{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktop/gnome.nix
    ../../modules/laptop/input.nix
  ];

  features = {
    dev.enable = true;
    gaming.enable = true;
    office.enable = true;
  };
}
