{ pkgs, config, inputs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
	layer = "top";
	position = "top";
	height = 30;
	spacing = 4;
	modules-left = [ "hyprland/workspaces" ];
	modules-center = [ "hyprland/window" ];
	modules-right = [
	  "pulseaudio"
	  "netowrk"
	  "cpu"
	  "memory"
	  "temperature"
	  "clock"
	  "tray"
	];
	"hyprland/workspaces" = {
	  on-click = "activate";
	  sort-by-number = true;
	};
	tray = {
	  spacing = 10;
	};
	clock = {
	  format = "{:%I:%M %p}";
	  tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calender}</small></tt>";
	  format-alt = "{:%Y-%m-%d}";
	};
      };
    };
    style = "
      @define-color base   #1e1e2e;
      @define-color mantle #181825;
      @define-color crust  #11111b;

      @define-color text     #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color subtext1 #bac2de;

      @define-color surface0 #313244;
      @define-color surface1 #45475a;
      @define-color surface2 #585b70;

      @define-color overlay0 #6c7086;
      @define-color overlay1 #7f849c;
      @define-color overlay2 #9399b2;

      @define-color blue      #89b4fa;
      @define-color lavender  #b4befe;
      @define-color sapphire  #74c7ec;
      @define-color sky       #89dceb;
      @define-color teal      #94e2d5;
      @define-color green     #a6e3a1;
      @define-color yellow    #f9e2af;
      @define-color peach     #fab387;
      @define-color maroon    #eba0ac;
      @define-color red       #f38ba8;
      @define-color mauve     #cba6f7;
      @define-color pink      #f5c2e7;
      @define-color flamingo  #f2cdcd;
      @define-color rosewater #f5e0dc;
      * {
        color: @text;
      }

      window#waybar {
	background-color: shade(@base, 0.9);
	border: 2px solid alpha(@crust, 0.3);
      }
    ";
  };
}

