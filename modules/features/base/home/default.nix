{
  ...
}:

{
  imports = [
    ./firefox.nix
    ./tailscale.nix
    ./dconf.nix
  ];

  programs.obsidian = {
    enable = true;
  };
}
