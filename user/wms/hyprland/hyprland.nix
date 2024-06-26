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
      exec-once = mako
      monitor = eDP-1, 1920x1080@60, 0x0, 1
    ";
    settings = {
      general = with config.colorScheme.palette; {
	border_size = 2;
	gaps_in = 2;
	gaps_out = 2;
        "col.active_border" = "rgba(${base0E}ff) rgba(${base09}ff) 60deg";
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
	  ", Print, exec, grimblast --freeze copy area"
	  "$mod, E, exec, thunar"
        ]
	++ (
	  # workspace binds
	  builtins.concatLists (builtins.genList (
	    x: let
	      ws = let
		c = (x + 1) / 10;
	      in
		builtins.toString (x + 1 - (c * 10));
	    in [
	      "$mod, ${ws}, workspace, ${toString (x + 1)}"
	      "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
	    ]
	  )
	  10)
	);
    };
  };

  # Mako notification configuration
  services.mako ={
    enable = true;
    defaultTimeout = 5000;
    ignoreTimeout = true;
    borderColor = "#89b4fa";
    textColor = "#cdd6f4";
    progressColor = "over #313244";
    backgroundColor = "#1e1e2e";
    anchor = "bottom-right";
  };
  
  # Wofi app menu config
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      width = 750;
      height = 400;
      always_parse_args = true;
      show_all = false;
      term = "alacritty";
      hide_scroll = true;
      print_command = true;
      insensitive = true;
      prompt = null;
      columns = 1;
    };
    style = "
      @define-color	rosewater  #f5e0dc;
      @define-color	rosewater-rgb  rgb(245, 224, 220);
      @define-color	flamingo  #f2cdcd;
      @define-color	flamingo-rgb  rgb(242, 205, 205);
      @define-color	pink  #f5c2e7;
      @define-color	pink-rgb  rgb(245, 194, 231);
      @define-color	mauve  #cba6f7;
      @define-color	mauve-rgb  rgb(203, 166, 247);
      @define-color	red  #f38ba8;
      @define-color	red-rgb  rgb(243, 139, 168);
      @define-color	maroon  #eba0ac;
      @define-color	maroon-rgb  rgb(235, 160, 172);
      @define-color	peach  #fab387;
      @define-color	peach-rgb  rgb(250, 179, 135);
      @define-color	yellow  #f9e2af;
      @define-color	yellow-rgb  rgb(249, 226, 175);
      @define-color	green  #a6e3a1;
      @define-color	green-rgb  rgb(166, 227, 161);
      @define-color	teal  #94e2d5;
      @define-color	teal-rgb  rgb(148, 226, 213);
      @define-color	sky  #89dceb;
      @define-color	sky-rgb  rgb(137, 220, 235);
      @define-color	sapphire  #74c7ec;
      @define-color	sapphire-rgb  rgb(116, 199, 236);
      @define-color	blue  #89b4fa;
      @define-color	blue-rgb  rgb(137, 180, 250);
      @define-color	lavender  #b4befe;
      @define-color	lavender-rgb  rgb(180, 190, 254);
      @define-color	text  #cdd6f4;
      @define-color	text-rgb  rgb(205, 214, 244);
      @define-color	subtext1  #bac2de;
      @define-color	subtext1-rgb  rgb(186, 194, 222);
      @define-color	subtext0  #a6adc8;
      @define-color	subtext0-rgb  rgb(166, 173, 200);
      @define-color	overlay2  #9399b2;
      @define-color	overlay2-rgb  rgb(147, 153, 178);
      @define-color	overlay1  #7f849c;
      @define-color	overlay1-rgb  rgb(127, 132, 156);
      @define-color	overlay0  #6c7086;
      @define-color	overlay0-rgb  rgb(108, 112, 134);
      @define-color	surface2  #585b70;
      @define-color	surface2-rgb  rgb(88, 91, 112);
      @define-color	surface1  #45475a;
      @define-color	surface1-rgb  rgb(69, 71, 90);
      @define-color	surface0  #313244;
      @define-color	surface0-rgb  rgb(49, 50, 68);
      @define-color	base  #1e1e2e;
      @define-color	base-rgb  rgb(30, 30, 46);
      @define-color	mantle  #181825;
      @define-color	mantle-rgb  rgb(24, 24, 37);
      @define-color	crust  #11111b;
      @define-color	crust-rgb  rgb(17, 17, 27);

      * {
        font-family: 'Inconsolata Nerd Font', monospace;
        font-size: 14px;
      }

      /* Window */
      window {
        margin: 0px;
        padding: 10px;
        border: 0.16em solid @mauve;
        border-radius: 0.1em;
        background-color: @base;
        animation: slideIn 0.5s ease-in-out both;
      }

      /* Slide In */
      @keyframes slideIn {
        0% {
           opacity: 0;
        }

        100% {
           opacity: 1;
        }
      }

      /* Inner Box */
      #inner-box {
        margin: 5px;
        padding: 10px;
        border: none;
        background-color: @base;
        animation: fadeIn 0.5s ease-in-out both;
      }

      /* Fade In */
      @keyframes fadeIn {
        0% {
           opacity: 0;
        }

        100% {
           opacity: 1;
        }
      }
      
      /* Outer Box */
      #outer-box {
        margin: 5px;
        padding: 10px;
        border: none;
        background-color: @base;
      }

      /* Scroll */
      #scroll {
        margin: 0px;
        padding: 10px;
        border: none;
        background-color: @base;
      }
  
      /* Input */
      #input {
        margin: 5px 20px;
        padding: 10px;
        border: none;
        border-radius: 0.1em;
        color: @text;
        background-color: @base;
        animation: fadeIn 0.5s ease-in-out both;
      }

      #input image {
          border: none;
          color: @red;
      }

      #input * {
        outline: 4px solid @red!important;
      }

      /* Text */
      #text {
        margin: 5px;
        border: none;
        color: @text;
        animation: fadeIn 0.5s ease-in-out both;
      }

      #entry {
        background-color: @base;
      }

      #entry arrow {
        border: none;
        color: @mauve;
      }

      /* Selected Entry */
      #entry:selected {
        border: 0.11em solid @mauve;
      }

      #entry:selected #text {
        color: @mauve;
      }

      #entry:drop(active) {
        background-color: @mauve!important;
      }
    ";
  };
}
