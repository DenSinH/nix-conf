{
  featureName,
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.features.${featureName};
in
{
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        # needed for uv:
        #       [stderr]
        #       Could not start dynamically linked executable: /home/dennis/.cache/uv/builds-v0/.tmpgcWBwv/bin/uv-build
        #       NixOS cannot run dynamically linked executables intended for generic
        #       linux environments out of the box. For more information, see:
        #       https://nix.dev/permalink/stub-ld
        #
        # see also:
        # https://wiki.nixos.org/wiki/Python#Running_Python_packages_which_requires_compilation_and/or_contains_libraries_precompiled_without_nix
        programs.nix-ld.enable = true;
        programs.nix-ld.libraries = with pkgs; [
          zlib
          zstd
          stdenv.cc.cc
          stdenv.cc.cc.lib
          curl
          openssl
          attr
          libssh
          bzip2
          libxml2
          acl
          libsodium
          util-linux
          xz
          systemd
        ];
        environment.variables = {
          "LD_LIBRARY_PATH" = "$NIX_LD_LIBRARY_PATH";
        };
      }
      (lib.mkIf cfg.docker {
        virtualisation.docker.enable = true;

        users.users.dennis = {
          extraGroups = [ "docker" ];
        };
      })
    ]
  );
}
