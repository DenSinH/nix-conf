{ config, pkgs, ... }:

{
  # automatic power management profiles
  services.power-profiles-daemon.enable = true;

  # automatic power switching
  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", \
      RUN+="${pkgs.systemd}/bin/systemctl start set-power-profile-performance.service"

    ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", \
      RUN+="${pkgs.systemd}/bin/systemctl start set-power-profile-balanced.service"
  '';

  systemd.services.set-power-profile-performance = {
    description = "Set performance profile on AC";

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance";
    };
  };

  systemd.services.set-power-profile-balanced = {
    description = "Set balanced profile on battery";

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced";
    };
  };
}
