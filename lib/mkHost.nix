{
  nixpkgs,
  system,
  inputs,
}:

{
  hostname,
  extraModules ? [ ],
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

    ../modules/common
    ({ networking.hostName = hostname; })
  ]
  ++ extraModules;
}
