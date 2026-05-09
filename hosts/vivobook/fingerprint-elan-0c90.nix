# see https://wiki.nixos.org/wiki/Fingerprint_scanner
# and
# https://gitlab.freedesktop.org/libfprint/libfprint/-/merge_requests/330#note_2578099
# for the MR that adds support for the 04f3:0c90 usb device ID (run lsusb)

{
  lib,
  pkgs,
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      libfprint = prev.libfprint.overrideAttrs (old: {
        src = prev.fetchFromGitLab {
          domain = "gitlab.freedesktop.org";
          owner = "depau";
          repo = "libfprint";
          rev = "elanmoc2";
          hash = "sha256-dxMls9Z5J9agesuNC46OoXAiYW/GcqWEEiAF7Y7DfwQ=";
        };

        # some check seems to fail
        installCheckPhase = "";
      });
    })
  ];

  services.fprintd = {
    enable = true;

    package = pkgs.fprintd.override {
      libfprint = pkgs.libfprint;
    };
    
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-elan;
    };
  };
}
