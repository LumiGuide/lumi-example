# This Nix expressions returns the package set from nixpkgs but extended and
# overridden by the packages in ./lumi.nix.
#
# The nix-build and nix-shell invocations in the Makefile use this expression by
# default.

import (import ./nixpkgs.nix) { config = import ./nixpkgs-config.nix; }
