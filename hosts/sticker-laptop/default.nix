{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/laptop/input.nix
    ../../modules/laptop/power.nix
  ];

  features = {
    dev = {
      enable = true;
      docker = true;
    };
    gaming.enable = true;
    office = {
      enable = true;
      powershell = true;
    };
  };
}
