# Nix configurations

These are my personal nixos configurations, and here are some instructions on how to use them, modify them and create new hosts.

## Creating a new host

In order to create a new host, do the following after installing 
NixOS:
- Edit your `/etc/nixos/configuration.nix` to have at least the following:
  ```nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    nano
    git
    wget
  ];
  ```
- Do a `nixos-rebuild switch` in order to apply the configuration.
- You now have `git` available, so clone the repository, for
  example to `~/nix-conf`.
- Add a folder `hosts/<your-host>` and add the `hardware-configuration.nix` by running
  ```
  nixos-generate-config --show-hardware-config > hardware-configuration.nix 
  ```
- Add a `default.nix` to this folder, you likely want to copy any
  of the existing ones. Modify it to your liking.
- Go to the repo root.
- Add the missing files to git, otherwise the flake does not pick it up, and run `nixos-rebuild switch --flake .#<your-host>`.
- Your configuration should be activated with your selected features!
