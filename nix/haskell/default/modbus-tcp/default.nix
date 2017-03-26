{ mkDerivation
, stdenv
, fetchgit

, attoparsec
, base
, bytestring
, exceptions
, monad-batcher
, mtl
, transformers

, QuickCheck
, tasty
, tasty-quickcheck
}:

mkDerivation {
  pname = "modbus-tcp";
  version = "HEAD";
  src = fetchgit {
    url = "https://github.com/roelvandijk/modbus-tcp.git";
    rev = "e6591d994e109ff28298062c5c990106df641ff4";
    sha256 = "04d0z9imim1gjvkkvx5xg4sscqawjgb5nfkr4w0hazb2aiybmw82";
  };
  libraryHaskellDepends = [
    attoparsec
    base
    bytestring
    exceptions
    monad-batcher
    mtl
    transformers
  ];
  testHaskellDepends = [
    QuickCheck
    tasty
    tasty-quickcheck
  ];
  homepage = "https://github.com/roelvandijk/modbus-tcp";
  description = "Communicate with Modbus devices over TCP";
  license = stdenv.lib.licenses.bsd3;
}
