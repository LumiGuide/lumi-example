{ mkDerivation
, stdenv
, lib

# Haskell libraries
, configurator
, containers
, data-default-class
, dimensional
, http-types
, lumi-hackage-extended
, monad-control
, servant-server
, systemd
, transformers-base
, unix
, wai
, wai-extra
, warp
}:
mkDerivation {
  pname = "lumi-example-hs-pkg";
  version = "0.0";
  src = lib.sourceByRegex ./. [
          "^lumi-example-hs-pkg.cabal$"
          "^src.*"
        ];
  isLibrary = true;
  libraryHaskellDepends = [
    configurator
    containers
    data-default-class
    dimensional
    http-types
    lumi-hackage-extended
    monad-control
    servant-server
    systemd
    transformers-base
    unix
    wai
    wai-extra
    warp
  ];
  license = stdenv.lib.licenses.unfree;
}
