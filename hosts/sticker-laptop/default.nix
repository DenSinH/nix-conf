{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktop/gnome.nix
    ../../modules/laptop/input.nix
  ];

  features = {
    gaming.enable = true;
    office.enable = true;
  };
}
