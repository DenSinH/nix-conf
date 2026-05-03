{ inputs, config, ... }:

{
  imports = [
    ./home-manager.nix
    ./system.nix
    ./users.nix
  ];
}
