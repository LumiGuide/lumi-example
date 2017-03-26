#
# LumiOS workstation base configuration
#
{ config, pkgs, lib, ... }:
with lib;
let cfg = config.workstation;
in {
  options = {
    mainUser = mkOption {
      type = types.str;
      description = ''
        The username of the main user account of this machine.
        This should be one of the users in the ../users directory.
      '';
    };
  };

  imports = [
    <lumi/os>
  ];

  config = {
    boot.cleanTmpDir = true;

    time.timeZone = "Europe/Amsterdam";

    # System-wide packages
    environment.systemPackages = with pkgs; [
      # In practise this contains all the programs that all engineers share.
    ];

    # Services and servers
    services = {
      # X11 windowing system.
      xserver = {
        enable = true;
        windowManager = {
	  xmonad = {
	    enable = true;
	    haskellPackages = pkgs.haskell.packages.ghc801;
	    extraPackages = hsPkgs: with hsPkgs; [
              xmonad-contrib
              xmonad-extras
            ];
	  };
          default = "xmonad";
	};
        desktopManager.default = "none";
      };
    };

    nixpkgs.config = import <lumi/nixpkgs-config.nix>;

    # Nix configuration
    nix = {
      nixPath = [
        "nixpkgs=${pkgs.path}"
        "lumi=/home/${mainUser}/engineering/lumi"
        "nixos-config=/home/${mainUser}/engineering/lumi/os/workstation/configuration.nix"
      ];
    };
  };
}
