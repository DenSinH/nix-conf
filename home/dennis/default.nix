{ config, pkgs, ... }:

{
  home.username = "dennis";
  home.homeDirectory = "/home/dennis";

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

  programs.git = {
    enable = true;
    settings = {
      user.name = "DenSinH";
      user.email = "git@dennishilhorst.nl";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        ms-python.python
      ];

      userSettings = {
        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 500;
      };
    };
  };

  # CLI tools
  home.packages = with pkgs; [
    wget
    nano
    nixfmt
    jetbrains.pycharm
    python313
    uv
  ];

  home.stateVersion = "25.11";
}
