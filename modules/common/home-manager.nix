{ inputs, config, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = {
    inherit inputs;

    # inject nixos-level features config into home-manager modules
    features = config.features;
  };

  home-manager.users.dennis = import ../../home/dennis;
}
