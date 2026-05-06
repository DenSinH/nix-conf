{
  featureName,
  pkgs,
  lib,
  features,
  ...
}:

{
  config = lib.mkIf features.${featureName}.enable {
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
      package = pkgs.vscode;

      profiles.default = {
        extensions =
          with pkgs.vscode-extensions;
          [
            bbenoist.nix
            ms-python.python
            redhat.vscode-xml
            eamodio.gitlens
          ]
          ++ lib.optionals features.${featureName}.docker [
            # useful docker extensions
            ms-azuretools.vscode-docker
            ms-vscode-remote.remote-containers
          ];

        userSettings = {
          "files.autoSave" = "afterDelay";
          "files.autoSaveDelay" = 500;
        };

        keybindings = [
          {
            # Ctrl + D for copy line below (similar to PyCharm)
            key = "ctrl+d";
            command = "editor.action.copyLinesDownAction";
            when = "editorTextFocus";
          }
        ];
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
  };
}
