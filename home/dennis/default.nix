{ config, pkgs, ... }@attrs:

let
  importFeatures = import ../../modules/features/import.nix attrs;
in
{
  home.username = "dennis";
  home.homeDirectory = "/home/dennis";

  imports = importFeatures { kind = "home"; };

  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}
