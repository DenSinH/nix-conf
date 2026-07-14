{
  pkgs,
  config,
  lib,
  ...
}:

{
  # firefox configuration
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    profiles.default = {
      isDefault = true;
      name = "Dennis";

      settings = {
        "gfx.webrender.all" = true;
        "layers.acceleration.force-enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "extensions.autoDisableScopes" = 0;
        "extensions.enabledScopes" = 15;
        "toolkit.telemetry.enabled" = false;
      };

      # search addons here:
      # https://nur.nix-community.org/repos/rycee/
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin

        (bitwarden.overrideAttrs (old: rec {
          # needs to work with currently installed version of VaultWarden
          version = "2026.5.1";
          file_id = "4827854";

          src = pkgs.fetchurl {
            # find your version url at
            # https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/versions/
            url = "https://addons.mozilla.org/firefox/downloads/file/${file_id}/bitwarden_password_manager-${version}.xpi";

            # fill this in using nix-prefetch-url
            sha256 = "sha256-jrtHVRijMLiLTiy6CGTFyhG+05BznLhPvyVuk4yRttk=";
          };
        }))
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
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
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

          # The version should be pinned
          updates_disabled = true;
        };
      };
    };
  };
}
