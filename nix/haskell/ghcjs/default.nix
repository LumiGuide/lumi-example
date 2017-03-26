pkgs : with pkgs.haskell.lib;
{
  overrides = self : super :
    let defaultPkgs = (import ../default pkgs).overrides self super;
        ghcjsPkgs = pkgs.lib.callPackagesFromDir self ./.;
    in    defaultPkgs
       // ghcjsPkgs
       // {
         jsaddle = doJailbreak (addBuildDepend super.jsaddle super.ghcjs-base);

         servant-client = doJailbreak defaultPkgs.servant-client;
       };
}
