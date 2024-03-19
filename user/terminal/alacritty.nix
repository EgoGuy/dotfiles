{ pkgs, config, ...}:

{
  imports= [
    ./catppuccin-mocha.nix
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
	decorations = "none";
	dynamic_padding = true;
	padding = {
	  x = 5;
	  y = 5;
	};
	startup_mode = "Maximized";
	opacity = 0.8;
      };

      scrolling.history = 10000;

      font = {
	normal.family = "Liberation Mono";
	bold.family = "Liberation Mono";
	italic.family = "Liberation Mono";
	size = 10;
      };

      colors.draw_bold_text_with_bright_colors = true;

    };
  };
}
