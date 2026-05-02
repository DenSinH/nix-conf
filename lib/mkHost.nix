{
  nixpkgs,
  system,
  inputs,
}:

{
  name,
}:

nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit inputs;
  };

  modules = [
    {
      nixpkgs.overlays = [
        inputs.nur.overlays.default
      ];
    }

    # define all feature options
    ../modules/features/options.nix

    ../modules/common
    ../modules/features/nixos.nix
    ({ networking.hostName = name; })

    ../hosts/${name}/default.nix
  ];
}
