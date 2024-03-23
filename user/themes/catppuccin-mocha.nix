{ config, pkgs, inputs, ... }:

{
  # overlay for now
  nixpkgs.overlays = [
    (final: prev: {
      pythonPackagesExtensions =
	prev.pythonPackagesExtensions
	++ [
	  (
	    python-final: python-prev: {
	      catppuccin = python-prev.catppuccin.overridePythonAttrs (oldAttrs: rec {
		version = "1.3.2";
		src = prev.fetchFromGitHub {
		  owner = "catppuccin";
		  repo = "python";
		  rev = "refs/tags/v${version}";
		  hash = "sha256-spPZdQ+x3isyeBXZ/J2QE6zNhyHRfyRQGiHreuXzzik==";
		};

		# can be removed next version
		disabledTestPaths = [
		  "tests/test_flavour.py"
		];
	      });
	    }
	  )
	];
    })
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Mauve-Dark";
      package = (pkgs.catppuccin-gtk.override {
	accents = [ "mauve" ];
	size = "compact";
	tweaks = [ "rimless" "black" ];
	variant = "mocha";
      });
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Mauve-Cursors";
      package = pkgs.catppuccin-cursors.mochaMauve;
      size = 24;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = (pkgs.catppuccin-papirus-folders.override{
    	accent = "mauve";
    	flavor = "mocha";
      });
    };
    gtk3.extraConfig = {
      Settings = "gtk-application-prefer-dark-theme=1";
    };
    gtk4.extraConfig = {
      Settings = "
	gtk-application-prefer-dark-theme=1
	gtk-cursor-theme-name=Catppuccin-Mocha-Mauve
      ";
    };
  };
  home.sessionVariables.GTK_THEME = "Gruvbox-Dark";

  # cursor config
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaMauve;
    name = "Catppuccin-Mocha-Mauve-Cursors";
    size = 24;
    gtk.enable = true;
  };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };
}
