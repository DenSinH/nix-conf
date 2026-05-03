{ inputs, config, ... }:

{
  imports = [
    ./gnome.nix
    ./home-manager.nix
    ./system.nix
    ./users.nix
  ];
}
