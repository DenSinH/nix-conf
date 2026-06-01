{ lib, ... }:

{
  kind, # nixos, home or options
}:

let
  dir = ./.;

  features = builtins.readDir dir;
  featureDirs = lib.filterAttrs (_: type: type == "directory") features;

  # potential paths in priority order
  mkPaths = featureName: [
    (dir + "/${featureName}/${kind}.nix")
    (dir + "/${featureName}/default.nix")
  ];

  pickPath = featureName: lib.findFirst builtins.pathExists null (mkPaths featureName);

  imports = lib.flatten (
    map (
      featureName:
      let
        path = pickPath featureName;
      in
      lib.optionals (path != null) [
        (
          {
            lib,
            pkgs,
            config,
            ...
          }@attrs:
          import path (
            attrs
            // {
              featureName = featureName;
            }
          )
        )
      ]
    ) (builtins.attrNames featureDirs)
  );
in
imports
