# Jellyfin2Samsung
# https://github.com/Jellyfin2Samsung/Samsung-Jellyfin-Installer
# packaged for NixOS
# you may need to configure some settings, notably:
# - The NIC that is used (this may not work if you are using a docking station!)
#   - If you are using a docking station and the install fails because of
#     "Error: Remote closed stream while reading"
#     the app may be using the wrong NIC (and so the wrong IP), and you may have to
#     manually disconnect any NIC that it might be using (VPN, docking station, etc.)
# - The server's autologin stuff so you don't have to re-login every time
# - A Github PAT (old-fashioned token, without any special rights), if it does not seem
#   to be fetching releases properly
{ pkgs, ... }:

let
  pname = "samsung-jellyfin-installer";
  version = "2.3.0.1";

  src = pkgs.fetchzip {
    url = "https://github.com/Jellyfin2Samsung/Samsung-Jellyfin-Installer/releases/download/v${version}/Jellyfin2Samsung-v${version}-linux-x64.tar.gz";
    hash = "sha256-ndHYwLUcUOHLx7Q0jsIeMYvhvDkOhxvdh98bhrmIvd4=";
    stripRoot = false;
  };
in
pkgs.buildFHSEnv {
  name = pname;

  targetPkgs =
    pkgs: with pkgs; [
      icu

      fontconfig

      xorg.libICE
      xorg.libSM
      xorg.libX11
    ];

  # the app expects the binary to be in a writable file system, as it
  # creates a Logs directory using AppContext.BaseDirectory
  runScript = pkgs.writeShellScript "run-${pname}" ''
    set -e

    # Runtime directory
    RUNTIME_DIR="''${XDG_STATE_HOME:-$HOME/.local/state}/${pname}"
    BINARY="$RUNTIME_DIR/Jellyfin2Samsung"

    if [ ! -f "$BINARY" ]; then
      mkdir -p "$RUNTIME_DIR"
      cp -r ${src}/* "$RUNTIME_DIR/"
      chmod -R u+w "$RUNTIME_DIR"
    fi

    exec "$BINARY" "$@"
  '';
}
