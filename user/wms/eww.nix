{ pkgs, config, inputs, ...}:
{
  # Home-manager setup for eww
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = "./eww"
  };
}
