{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/laptop/input.nix
  ];

  features = {
    dev.enable = true;
    gaming.enable = true;
    office.enable = true;
  };
}
