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
      mkHost = import ./lib/mkHost.nix {
        inherit nixpkgs system inputs;
      };
    in
    {
      nixosConfigurations = {
        sticker-laptop = mkHost {
          hostname = "sticker-laptop";
          extraModules = [
            ./hosts/sticker-laptop
            ./modules/common
            ./modules/desktop/gnome.nix
            ./modules/laptop/input.nix
            ./modules/features/gaming.nix
          ];
        };
      };

      formatter.${system} = pkgs.nixfmt-tree;
    };
}
