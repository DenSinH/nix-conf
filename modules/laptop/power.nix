{
  config,
  pkgs,
  lib,
  ...
}:

let
  setPowerProfile = pkgs.writeShellScript "set-power-profile" ''
    #!/usr/bin/env bash

    for supply in /sys/class/power_supply/*; do
      if [ -f "$supply/type" ] && [ "$(cat "$supply/type")" = "Mains" ]; then
        if [ "$(cat "$supply/online")" = "1" ]; then
          ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance
          exit 0
        fi
      fi
    done

    ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-save
  '';
in
{
  # automatic power management profiles
  services.power-profiles-daemon.enable = true;

  # react to charger plug/unplug
  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", \
      RUN+="${pkgs.systemd}/bin/systemctl start set-power-profile.service"
  '';

  # shared service used by both boot and udev
  systemd.services.set-power-profile = {
    description = "Set appropriate power profile";

    after = [ "power-profiles-daemon.service" ];
    wants = [ "power-profiles-daemon.service" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = setPowerProfile;
    };
  };
}
