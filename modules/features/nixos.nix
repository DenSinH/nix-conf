{ lib, pkgs, ... }@attrs:

let
  importFeatures = import ./_lib/importFeatures.nix attrs;

in
importFeatures {
  kind = "nixos";
}
