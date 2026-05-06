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
        core.editor = "code --wait";
      };
    };

    programs.vscode = {
      enable = true;
      package = pkgs.vscode;

      profiles.default = {
        extensions =
          with pkgs.vscode-extensions;
          [
            # programming languages
            bbenoist.nix
            jnoortheen.nix-ide
            ms-python.python
            # data files
            redhat.vscode-xml
            mechatroner.rainbow-csv
            # general (git, remote dev, ...)
            eamodio.gitlens
            mhutchie.git-graph
            ms-vscode-remote.remote-ssh
            gruntfuggly.todo-tree
          ]
          ++ lib.optionals features.${featureName}.docker [
            # useful docker extensions
            ms-azuretools.vscode-docker
            ms-vscode-remote.remote-containers
          ];

        userSettings = {
          "files.autoSave" = "afterDelay";
          "files.autoSaveDelay" = 500;
          "files.associations" = {
            "*.nix" = "nix";
          };
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
