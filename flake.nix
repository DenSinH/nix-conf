{
  description = "Multi-host NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nur,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      overlays = [
        inputs.nur.overlays.default
      ];

      mkSystem = import ./lib/mksystem.nix {
        inherit overlays nixpkgs inputs;
      };

      # gather hosts
      hostDir = ./hosts;
      hostNames = builtins.attrNames (builtins.readDir hostDir);
      hostConfigs = pkgs.lib.filter (
        name: builtins.pathExists (hostDir + "/${name}/default.nix")
      ) hostNames;
    in
    {
      nixosConfigurations = pkgs.lib.listToAttrs (
        map (name: {
          inherit name;
          value = mkSystem name { inherit system; };
        }) hostConfigs
      );

      formatter.${system} = pkgs.nixfmt-tree;
      samsung-jellyfin-installer = (pkgs.callPackage ./modules/samsung-jellyfin-installer.nix { });
    };
}
