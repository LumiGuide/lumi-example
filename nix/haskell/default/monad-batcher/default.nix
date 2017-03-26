{ mkDerivation, base, exceptions, fetchgit, stdenv }:
mkDerivation {
  pname = "monad-batcher";
  version = "0.0.0.0";
  src = fetchgit {
    url = "https://github.com/basvandijk/monad-batcher";
    rev = "cc524e2d78ce1a8c0daa91bb26b88bc4abdf3c56";
    sha256 = "08rzihrmhp2ld2cjql0ifym0mpknxy5lh2izyxs69w98r7g06c1v";
  };
  libraryHaskellDepends = [ base exceptions ];
  homepage = "https://github.com/basvandijk/monad-batcher";
  description = "An applicative monad that batches commands for later more efficient execution";
  license = stdenv.lib.licenses.bsd3;
}
