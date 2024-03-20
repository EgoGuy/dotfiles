{

  description = "Byrd's Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";

    nix-colors.url = "github:misterio77/nix-colors";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };
  

  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs: 
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      byrdmachine = lib.nixosSystem {
        inherit system;
	specialArgs = { inherit inputs; };
        modules = [ ./configuration.nix ];
      };
    };
    homeConfigurations = {
      xanderm = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	extraSpecialArgs = { inherit inputs; };
        modules = [ 
	  ./home.nix
	  # hyprland.homeManagerModules.default
	  # {wayland.windowManager.hyprland.enable = true;}
        ];
      };	
    };
  }; 
  
}
