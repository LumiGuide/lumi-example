# This expression returns the nix/store path to our version of nixpkgs.
# It ensures that all engineers use the same revision of nixpkgs.
# It is used in the following files:
#
# * ./default.nix:
#   import (import ./nixpkgs.nix) { ... }
#
# * ./Makefile:
#   export NIX_PATH:=nixpkgs=$(shell nix-build --no-out-link ./nixpkgs.nix)
#
# Note that this expression requires that "nixpkgs" can be found in the
# NIX_PATH. However, since this expression defines the path to nixpkgs we have a
# bootstrapping problem. To bootstrap a workstation we will create an install-cd
# which has a copy of nixpkgs in its nix/store and set its NIX_PATH to that
# store path.
#
# We also have the bootstrapping problem on hydra.lumi.guide. Here we "solve" it
# by adding nixpkgs as an input like:
#
#   nixpkgs "Git checkout" https://github.com/NixOS/nixpkgs.git nixos-17.03-small
#
# This technique was inspired by the article:
#
#   Reproducible Development Environments by Rok Garbas
#   https://garbas.si/2015/reproducible-development-environments.html

let pkgs = import <nixpkgs> {};
    nixpkgsVersion = pkgs.lib.importJSON ./nixpkgs-version.json;
in pkgs.fetchFromGitHub {
     owner  = "NixOS";
     repo   = "nixpkgs-channels";
     rev    = nixpkgsVersion.rev;
     sha256 = nixpkgsVersion.sha256;
   }

# Uncomment the following to use a local nixpkgs tree:
# let pkgs = import <nixpkgs> {};
# in pkgs.runCommand "nixpkgs-local" {nixpkgs = ../nixpkgs;} "cp -rT $nixpkgs $out"
