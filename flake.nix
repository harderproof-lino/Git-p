{
 description = "NixOs - Rumda rice";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nixos-machine = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.lino = { pkgs, ... }: {
            home.stateVersion = "26.05";

            home.packages = with pkgs; [
              quickshell
              rofi-wayland
              ghostty
              brightnessctl
              wireplumber
              wl-clipboard
              jq
              libgtop
              grim
              slurp
              swappy
            ];
          };
        }
      ];
    };
  };
}

