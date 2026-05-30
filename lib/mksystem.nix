{
  nixpkgs,
  overlays,
  inputs,
}:

name:
{
  system,
}:

let
  importFeatures = import ../modules/features/import.nix {
    lib = nixpkgs.lib;
  };
in
nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit inputs;
  };

  modules = [
    # add all overlays
    { nixpkgs.overlays = overlays; }

    # add common modules (gnome, default programs, ...)
    ../modules/common

    # set hostname for system
    { networking.hostName = name; }

    # add host configuration
    ../hosts/${name}/default.nix
  ]
  ++ (importFeatures {
    kind = "options";
  })
  ++ (importFeatures {
    kind = "nixos";
  });
}
