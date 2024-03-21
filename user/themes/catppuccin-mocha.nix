{ config, pkgs, inputs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Mauve-Dark";
      package = pkgs.catppuccin-gtk.override {
	accents = [ "mauve" ];
	size = "compact";
	tweaks = [ "rimless" "black" ];
	variant = "mocha";
      };
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Mauve-Cursors";
      package = pkgs.catppuccin-cursors.mochaMauve;
      size = 24;
    };
  };

  # cursor config
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaMauve;
    name = "Catppuccin-Mocha-Mauve-Cursors";
    size = 24;
  };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };
}
