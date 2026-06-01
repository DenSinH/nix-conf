{
  pkgs,
  config,
  ...
}:

{
  # Tailscale systemtray service
  systemd.user.services.tailscale-systray = {
    Unit = {
      Description = "Tailscale Systray";
      After = [ "tailscaled.service" ];
      Wants = [ "tailscaled.service" ];
    };

    Service = {
      Type = "simple";

      # this also starts the systray service
      ExecStart = "${pkgs.tailscale}/bin/tailscale systray set --operator=${config.home.username}";

      Restart = "on-failure";
      RestartSec = 2;
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
