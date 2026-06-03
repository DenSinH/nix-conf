{ pkgs, ... }:

{
  # Packages for configuring my LogiTech MX Master 2S mouse
  environment.systemPackages = with pkgs; [
    solaar
    logiops
  ];

  services.logiops.enable = true;
  services.logiops.config = {
    devices = [
      {
        name = "MX Master 2S";

        smartshift = {
          on = true;
          threshold = 30;
        };

        hiresscroll = {
          hires = true;
          invert = false;
          target = false;
        };

        dpi = 1000;
      }
    ];
  };
}
