{
  description = "dev macbook pro";
  inputs = {
    # Where we get most of our software. Giant mono repo with recipes
    # called derivations that say how to build software.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # nixos-22.11

    # Manages configs links things into your home directory
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Controls system level software and settings including fonts
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Install homebrew as well
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };
  outputs = inputs@{ nixpkgs, home-manager, darwin, nix-homebrew, ... }:
  let
    config = (import ./config.nix {});
  in
  {
    system = "aarch64-darwin";
    darwinConfigurations.mbp-dev = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
        config.permittedInsecurePackages = [ "python-2.7.18.8" ]; # TODO: "${config.permittedInsecurePackages}"
      };
      modules = [
        ./modules/darwin
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            autoMigrate = true;
            user = "${config.username}";
          };
        }
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${config.username}.imports = [ ./modules/home-manager ];
          };
        }
      ];
    };
  };
}
