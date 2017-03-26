{ mkDerivation
, stdenv
, fetchgit

, base
, containers
, dimensional
, exact-pi
, parsec
, scientific
}:
mkDerivation {
  pname = "dimensional-parser";
  version = "HEAD";
  src = fetchgit ( import ./version.nix );
  libraryHaskellDepends =
    [ base
      containers
      dimensional
      exact-pi
      parsec
      scientific
    ];
  homepage = "lumiguide.eu";
  license = stdenv.lib.licenses.bsd3;
  maintainers = [ "roel@lambdacube.nl" ];
}
