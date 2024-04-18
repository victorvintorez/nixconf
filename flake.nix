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

		snowfall-lib = {
			url = "github:snowfallorg/lib";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		flake-compat = {
			url = "github:inclyc/flake-compat";
			flake = false;
		};

		sops-nix = {
			url = "github:Mic92/sops-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		impermanence.url = "github:nix-community/impermanence";
		persist-retro.url = "github:Geometer1729/persist-retro";

		disko = {
			url = "github:nix-community/disko";
			inputs.nixpkgs.follows = "nixpkgs";
		};

        nix-ld = {
            url = "github:Mic92/nix-ld";
            inputs.nixpkgs.follows = "nixpkgs";
        };

		# Hyprland
		hyprland = {
			url = "github:hyprwm/Hyprland";
		};

		nix-colors.url = "github:Misterio77/nix-colors";
  };

  outputs = inputs: let
		lib = inputs.snowfall-lib.mkLib {
			inherit inputs;
			src = ./.;
			snowfall = {
				meta = {
					name = "nixconf";
					title = "nixconf";
				};

				namespace = "nixconf";
			};
		};
		in
			(lib.mkFlake {
				inherit inputs;
				src = ./.;

				channels-config = {
					allowUnfree = true;
					# permittedInsecurePackages = [
          	        #     "electron-24.8.6"
        	        # ];
				};

				overlays = with inputs; [];

				systems = {
                    modules.nixos = with inputs; [
                        nix-ld.nixosModules.nix-ld
                        disko.nixosModules.disko
                        impermanence.nixosModules.impermanence
                        persist-retro.nixosModules.persist-retro
                        {
                            fileSystems."/persist".neededForBoot = true;
                        }
                    ];

                    hosts = {
                        supernova.modules = with inputs; [
                            (import ./disks/default.nix {
                                mainDiskId = "desktop main disk";
                                extraDiskIds = [];
                            })
                            {
                                fileSystems."/persist".neededForBoot = true;
                            }
                        ];

                        wormhole.modules = with inputs; [
                            (import ./disks/default.nix {
                                mainDiskId = "laptop main disk";
                                extraDiskIds = [];
                            })
                            {
                                fileSystems."/persist".neededForBoot = true;
                            }
                        ];
                    };
                };

                templates = import ./templates {};
			})
}
