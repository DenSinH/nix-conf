{ config, pkgs, ... }:

{
  # automatic power management profiles
  services.power-profiles-daemon.enable = true;
}
