# A base configuration for all LumiGuide machines which defines the following
# among other things:
#
# * It overrides nixpkgs to extend and override it with LumiGuide specific packages.
# * enables OpenSSH.
# * In practise it does a bunch of other things as well like adding user accounts for all engineers.
{
  imports = [
    <lumi/os>
  ];

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = import <lumi/lumi.nix>;
  };

  boot.cleanTmpDir = true;

  services.openssh.enable = true;
}
