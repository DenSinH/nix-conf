{
  pkgs,
  ...
}:

{
  programs.firefox = {
    enable = true;

    profiles.default = {
      isDefault = true;
      name = "Dennis";

      settings = {
        "gfx.webrender.all" = true;
        "layers.acceleration.force-enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "extensions.autoDisableScopes" = 0;
        "extensions.enabledScopes" = 15;
      };

      # search addons here:
      # https://nur.nix-community.org/repos/rycee/
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
      ];

      # see https://hugosum.com/blog/customizing-firefox-with-nix-and-home-manager#enable-firefox-extensions-with-policiesjson
      search = {
        force = true;

        engines = {
          # search nix packages with @nix prefix
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nix" ];
          };
        };
      };
    };

    # see also:
    # https://hugosum.com/blog/customizing-firefox-with-nix-and-home-manager#enable-firefox-extensions-with-policiesjson
    policies = {
      Extensions = {
        Locked = [
          # enable both extensions
          "uBlock0@raymondhill.net"
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" # Extension ID for bitwarden
        ];
      };
      ExtensionSettings = {
        # pin both extensions in the navbar
        "uBlock0@raymondhill.net" = {
          default_area = "navbar";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          default_area = "navbar";
          installation_mode = "force_installed";
          private_browsing = true;
        };
      };
    };
  };

  # base features are always enabled
  dconf.settings = {
    "org/gnome/shell" = {
      # Dash menu settings
      favorite-apps = [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "code.desktop"
        "org.gnome.Terminal.desktop"
      ];
    };
    "org/gnome/gnome-session" = {
      logout-prompt = false;
    };
    # keybinds
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-left = [ ];
      switch-to-workspace-right = [ ];
    };

    # find app names with
    # ls /run/current-system/sw/share/applications
    # or by looking for the shortcut name with
    # grep -Ril "Shortcut Name" /run/current-system/sw/share/applications/
    # or by going to
    # org/gnome/shell/app-picker-layout
    # in the dconf editor
    "org/gnome/desktop/app-folders" = {
      folder-children = [ "System" ];
    };

    "org/gnome/desktop/app-folders/folders/System" = {
      name = "System";
      apps = [
        # these apps created shortcuts by default
        # most of these, I will likely never use, but I just
        # wanted to group them and hide them away somewhere
        "cups.desktop" # Manage Printing
        "htop.desktop"
        "ca.desrt.dconf-editor.desktop"
        "xterm.desktop"
        "org.gnome.FileRoller.desktop"
        "org.gnome.eog.desktop"
        "org.gnome.Extensions.desktop"
        "nixos-manual.desktop"
      ];
    };
  };
}
