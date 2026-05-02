{ pkgs, ... }:

{
  users.users.dennis = {
    isNormalUser = true;
    description = "Dennis Hilhorst";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };
}
