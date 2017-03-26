# This function is used as the packageOverrides function (See the NixOS option:
# nixpkgs.config.packageOverrides). It extends and overrides the packages set
# from nixpks with 3rd-party packages from ./nix and LumiGuide specific packages
# which are defined in this file.
#
# Only place LumiGuide specific packages in this file! 3rd-party packages which
# in the future could be added to nixpkgs should be placed in ./nix/default.nix.
super : let self = super.pkgs; in

import ./nix super // {
  lumi = rec {

  # In practise this set contains a lot of LumiGuide specific packages...

  };
}
