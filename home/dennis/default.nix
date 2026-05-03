{ config, pkgs, ... }@attrs:

let
  importFeatures = import ../../modules/features/import.nix attrs;
in
{
  home.username = "dennis";
  home.homeDirectory = "/home/dennis";

  imports = importFeatures { kind = "home"; };

  programs.home-manager.enable = true;

  programs.firefox = {
    enable = true;

    profiles.default = {
      isDefault = true;
      name = "Dennis";

      settings = {
        "extensions.autoDisableScopes" = 0;
        "extensions.enabledScopes" = 15;
      };

      # search addons here:
      # https://nur.nix-community.org/repos/rycee/
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
      ];
    };
  };

  home.stateVersion = "25.11";
}
