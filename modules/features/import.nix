{ lib, ... }:

{
  kind, # nixos, home or options
}:

let
  dir = ./.;

  entries = builtins.readDir dir;

  featureDirs = lib.filterAttrs (name: type: type == "directory") entries;

  mkPath = featureName: dir + "/${featureName}/${kind}.nix";

  imports = lib.flatten (
    map (
      featureName:
      let
        path = mkPath featureName;
      in
      lib.optionals (builtins.pathExists path) [
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
