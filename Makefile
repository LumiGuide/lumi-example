.PHONY: help
help:
	@less Makefile

.DELETE_ON_ERROR:

export NIX_PATH:=nixpkgs=$(shell nix-build --no-out-link ./nixpkgs.nix):lumi=$(shell pwd):nixos-config=./os/workstation/configuration.nix

################################################################################
# Workstation
################################################################################

workstation.build:
	nixos-rebuild build

workstation.dry-build:
	nixos-rebuild dry-build

workstation.switch:
	sudo -E nixos-rebuild switch

workstation.test:
	sudo -E nixos-rebuild test

workstation.repl:
	nix-repl '<nixpkgs/nixos>'


################################################################################
# hs-pkgs
#
# Example:
# > make hs-pkgs.lumi-system.shell
# > make hs-pkgs.lumi-hackage-extended.repl

.PHONY: hs-pkgs.%.shell
hs-pkgs.%.shell:
	cd hs-pkgs/$* && \
	nix-shell --command \
	'cabal configure --builddir=dist --enable-tests; return;'

.PHONY: hs-pkgs.%.repl
hs-pkgs.%.repl:
	cd hs-pkgs/$* && \
	nix-shell --command \
	'cabal configure --builddir=dist --enable-tests; cabal repl; return;'


################################################################################
# my-net

.PHONY: my-net.create
my-net.create:
	nixops create -s deployment/state.nixops -d my-net \
	'<lumi/deployment/my-net.nix>' '<lumi/deployment/my-net-hardware.nix>'

.PHONY: my-net.info
my-net.info:
	nixops info -s deployment/state.nixops -d my-net

.PHONY: my-net.modify
my-net.modify:
	nixops modify -s deployment/state.nixops -d my-net \
	'<lumi/deployment/my-net.nix>' '<lumi/deployment/my-net-hardware.nix>'

.PHONY: my-net.build
my-net.build:
	nixops deploy -s deployment/state.nixops -d my-net --build-only

.PHONY: my-net.gc
my-net.gc:
	nixops ssh-for-each -s deployment/state.nixops -d my-net \
	-- nix-collect-garbage --delete-old


################################################################################
# Common deployment recipes

NIXOPS_BUILD   = nixops deploy  -s deployment/state.nixops -d my-net --include $(basename $@) --build-only
NIXOPS_COPY    = nixops deploy  -s deployment/state.nixops -d my-net --include $(basename $@) --copy-only
NIXOPS_DEPLOY  = nixops deploy  -s deployment/state.nixops -d my-net --include $(basename $@)
NIXOPS_DESTROY = nixops destroy -s deployment/state.nixops -d my-net --include $(basename $@)
NIXOPS_SSH     = nixops ssh     -s deployment/state.nixops -d my-net           $(basename $@)
NIXOPS_GC      = $(NIXOPS_SSH) nix-collect-garbage --delete-old

GIT_LOG_DELTA = git log $(shell nixops ssh -s deployment/state.nixops -d my-net $(basename $@) 'cat /etc/lumi-revision')..


################################################################################
# Facility 1

.PHONY: facility-1.build
facility-1.build:
	$(NIXOPS_BUILD)

.PHONY: facility-1.copy
facility-1.copy:
	$(NIXOPS_COPY)

.PHONY: facility-1.deploy
facility-1.deploy:
	$(NIXOPS_DEPLOY)

.PHONY: facility-1.ssh
facility-1.ssh:
	$(NIXOPS_SSH)

.PHONY: facility-1.log-delta
facility-1.log-delta:
	$(GIT_LOG_DELTA)

.PHONY: facility-1.gc
facility-1.gc:
	$(NIXOPS_GC)


################################################################################
# Facility 2

.PHONY: facility-2.build
facility-2.build:
	$(NIXOPS_BUILD)

.PHONY: facility-2.copy
facility-2.copy:
	$(NIXOPS_COPY)

.PHONY: facility-2.deploy
facility-2.deploy:
	$(NIXOPS_DEPLOY)

.PHONY: facility-2.ssh
facility-2.ssh:
	$(NIXOPS_SSH)

.PHONY: facility-2.log-delta
facility-2.log-delta:
	$(GIT_LOG_DELTA)

.PHONY: facility-2.gc
facility-2.gc:
	$(NIXOPS_GC)

# ...
