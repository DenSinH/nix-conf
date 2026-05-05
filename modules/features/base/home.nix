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
  };
}
