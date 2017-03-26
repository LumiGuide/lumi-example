pkgs : with pkgs.haskell.lib;
{
  overrides = self : super :
    let defaultPkgs = (import ../default pkgs).overrides self super;
        enableExecutableProfiling = drv :
          overrideCabal drv (drv: { enableExecutableProfiling = true; });
    in {
        mkDerivation = args: super.mkDerivation (args // {
          enableLibraryProfiling = true;
        });
      } //
      (defaultPkgs // {

        # The test-suite seems to hang on hydra.lumi.guide.
        extra = dontCheck super.extra;
      });
}
