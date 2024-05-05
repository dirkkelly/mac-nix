#!/bin/zsh
nix --extra-experimental-features nix-command --extra-experimental-features flakes run nix-darwin -- switch --flake ~/src/mac-nix#mbp-dev

