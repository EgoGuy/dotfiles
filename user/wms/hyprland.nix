{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./waybar.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = "
      exec-once = swww init
      exec-once = waybar
      monitor = eDP-1, 1920x1080@60, 0x0, 1
    ";
    settings = {
      general = with config.colorScheme.colors; {
	border_size = 2;
	gaps_in = 5;
	gaps_out = 5;
        "col.active_border" = "rgba(${config.colorScheme.palette.base0E}ff) rgba(${config.colorScheme.palette.base09}ff) 60deg";
	"col.inactive_border" = "rgba(${base00}ff)";
	layout = "dwindle";

      };

      decoration = {
        rounding = 0;
	drop_shadow = true;
	"col.shadow" = "rgba(00000099)";
	blur = {
	  enabled = true;
	  size = 8;
	  passes = 1;
	  new_optimizations = true;
	};
      };

      misc = {
	disable_hyprland_logo = true;

      };

      "$mod" = "SUPER";

      bindm = [
        "$mod, mouse:272, movewindow"
	"$mod, mouse:273, resizewindow"
	"$mod ALT, mouse:272, resizewindow"
      ];

      bind =
        [
	  "$mod, Q, exec, alacritty" 
	  "$mod, X, killactive,"
	  "$mod, V, togglefloating,"
	  "$mod, M, exit"
	  "$mod, Space, exec, wofi --show drun"
	  ", Print, exec, grimblast copy area"
	  "$mod, E, exec, thunar"
        ];

    };
  };
}
