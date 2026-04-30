{ config, pkgs, ... }:

{
  home.username = "dennis";
  home.homeDirectory = "/home/dennis";

  programs.home-manager.enable = true;
  
  programs.firefox.enable = true;

  programs.git = {
    enable = true;
    extraConfig = {
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

  # CLI tools (move from systemPackages)
  home.packages = with pkgs; [
    wget
    nano
    nixfmt
  ];

  home.stateVersion = "25.11";
}