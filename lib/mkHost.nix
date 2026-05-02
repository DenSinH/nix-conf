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
    ../modules/common
    ({ networking.hostName = hostname; })
  ]
  ++ extraModules;
}
