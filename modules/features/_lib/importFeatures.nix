{ lib, ... }@attrs:

{
  dir,
  kind,  # nixos, home or options
}:

let
  entries = builtins.readDir dir;

  featureDirs = lib.filterAttrs (name: type: type == "directory" && name != "_lib") entries;

  mkPath = featureName: dir + "/${featureName}/${kind}.nix";
in
{
  imports = lib.flatten (
    map (
      featureName:
      let
        path = mkPath featureName;
        updatedAttrs = attrs // {
          featureName = featureName;
        };
      in
      lib.optionals (builtins.pathExists path) [ 
        (import path updatedAttrs)
      ]
    ) (builtins.attrNames featureDirs)
  );

  options = if kind == "options" then
    let
      mkFeatureOption =
        name:
        lib.nameValuePair name ({
          enable = lib.mkEnableOption "feature: ${name}";
        });

        enableOptions = lib.listToAttrs (map mkFeatureOption (builtins.attrNames featureDirs));
    in
    {
      features = enableOptions;
    }
  else
    {};
}
