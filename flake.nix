{
  description = "VictorVintorez's nixos configuration";

  # Cachix
  nixConfig = {
	extra-substituters = [
	  "https://cache.nixos.org"
	  "https://hyprland.cachix.org"
	];

	extra-trusted-public-keys = [
	  "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
	  "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
	];
  };

  inputs = {
	# Nixpkgs
	nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	
	# Home manager
	home-manager = {
	  url = "github:nix-community/home-manager";
	  inputs.nixpkgs.follows = "nixpkgs";
	};

	# agenix
	agenix = {
	  url = "github:ryantm/agenix";
	  inputs.nixpkgs.follows = "nixpkgs";
	};

	# Nix-hardware
	hardware.url = "github:nixos/nixos-hardware";

	# Hyprland
	hyprland = {
	  url = "github:hyprwm/Hyprland";
	};


  };

  outputs = {
	self,
	nixpkgs,
	home-manager,
	...
  } @ inputs: let
	inherit (self) outputs;
	# Supported systems for your flake packages, shell, etc.
	systems = [
	  "x86_64-linux"
	  "aarch64-darwin"
	  "x86_64-darwin"
	];
	# This is a function that generates an attribute by calling a function you
	# pass to it, with each system as an argument
	forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
	# Your custom packages
	# Accessible through 'nix build', 'nix shell', etc
	packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
	# Formatter for your nix files, available through 'nix fmt'
	# Other options beside 'alejandra' include 'nixpkgs-fmt'
	formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

	# Your custom packages and modifications, exported as overlays
	overlays = import ./overlays {inherit inputs;};
	# Reusable nixos modules you might want to export
	nixosModules = import ./modules/nixos;
	# Reusable home-manager modules you might want to export
	homeManagerModules = import ./modules/home-manager;

	# NixOS configuration entrypoint
	# Available through 'nixos-rebuild --flake .#your-hostname'
	nixosConfigurations = {
		# Supernova - Desktop
		supernova = nixpkgs.lib.nixosSystem {
			specialArgs = {inherit inputs outputs;};
			modules = [
		  		./nixos/supernova/configuration.nix
			];
		};

		# Wormhole - Laptop
		wormhole = nixpkgs.lib.nixosSystem {
			specialArgs = {inherit inputs outputs;};
			modules = [
		  		./nixos/wormhole/configuration.nix
			];
		};
	};

	# Standalone home-manager configuration entrypoint
	# Available through 'home-manager --flake .#your-username@your-hostname'
	homeConfigurations = {
		# Victor - Supernova
		"victorv@supernova" = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
			extraSpecialArgs = {inherit inputs outputs;};
			modules = [
				# > Our main home-manager configuration file <
				./home-manager/victorv/supernova/home.nix
			];
		};

		# Victor - Wormhole
		"victorv@wormhole" = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
			extraSpecialArgs = {inherit inputs outputs;};
			modules = [
				# > Our main home-manager configuration file <
				./home-manager/victorv/wormhole/home.nix
			];
		};
	};
  };
}
