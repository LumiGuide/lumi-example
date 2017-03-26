{ mkDerivation
, fetchgit
, stdenv
, lib

, opencv3

# library dependencies
, aeson
, base
, base64-bytestring
, bindings-DSL
, bytestring
, containers
, deepseq
, inline-c
, inline-c-cpp
, linear
, primitive
, repa
, template-haskell
, text
, transformers
, vector

# test dependencies
, directory
, Glob
, haskell-src-meta
, haskell-src-exts
, QuickCheck
, tasty
, tasty-hunit
, tasty-quickcheck

# benchmark dependencies
, criterion
}:
mkDerivation {
  pname = "opencv";
  version = "HEAD";

  src = fetchgit ( import ./version.nix );

  libraryHaskellDepends = [
    aeson
    base
    base64-bytestring
    bindings-DSL
    bytestring
    containers
    deepseq
    inline-c
    inline-c-cpp
    linear
    primitive
    repa
    template-haskell
    text
    transformers
    vector
  ];
  testHaskellDepends = [
    base
    containers
    directory
    Glob
    haskell-src-meta
    haskell-src-exts
    QuickCheck
    tasty
    tasty-hunit
    tasty-quickcheck

    criterion
  ];
  libraryPkgconfigDepends = [ opencv3 ];
  configureFlags =
    [ "--with-gcc=g++"
      "--with-ld=g++"
    ];
  hardeningDisable = [ "bindnow" ];
  homepage = "https://github.com/LumiGuide/haskell-opencv";
  license = stdenv.lib.licenses.bsd3;
}
