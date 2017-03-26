pkgs : with pkgs.haskell.lib;
let Werror = drv: appendConfigureFlag drv "--ghc-option=-Wall --ghc-option=-Werror";
in {
  overrides = self : super :
    let defaultPkgs = pkgs.lib.callPackagesFromDir self ./.;
        lumiHsPkgs = pkgs.lib.mapAttrs (_name: Werror)
                                       (pkgs.lib.callPackagesFromDir self <lumi/hs-pkgs>);
    in    defaultPkgs
       // lumiHsPkgs
       // { crypto-conduit  = doJailbreak super.crypto-conduit;
            fsutils         = doJailbreak super.fsutils;
            servant-swagger = doJailbreak super.servant-swagger;
          };
}
