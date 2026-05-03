{
  nixpkgs,
  system,
  inputs,
}:

let
  importFeatures = import ../modules/features/import.nix {
    lib = nixpkgs.lib;
  };
in
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

    ../modules/common
    ({ networking.hostName = name; })

    ../hosts/${name}/default.nix
  ]
  ++ (importFeatures {
    kind = "nixos";
  })
  ++ (importFeatures {
    kind = "options";
  });
}
