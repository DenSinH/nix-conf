{ inputs, config, ... }:

{
  imports = [
    ./system.nix
    ./users.nix
    ./home-manager.nix
  ];
}
