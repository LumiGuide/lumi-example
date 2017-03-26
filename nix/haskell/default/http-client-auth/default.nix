# http-client-auth from hackage doesn't work with our Axis camera's. The problem
# seems to be that the version from hackage doesn't intersperse comma's between
# the fields of the Authorization header. We override this package here with a
# fork on GitHub.
# TODO (BvD): Ask the authors to upload this version to Hackage.

{ mkDerivation, fetchgit, base, base64-string, blaze-builder, bytestring
, case-insensitive, conduit, crypto-conduit
, http-conduit, mtl, pureMD5, resourcet, stdenv
, transformers, utf8-string

# Test dependencies
#, doctest, directory, Glob, hlint
}:
mkDerivation {
  pname = "http-client-auth";
  version = "HEAD";
  src = fetchgit {
    url = "https://github.com/LumiGuide/http-client-auth.git";
    rev = "acf4d56415f078c63d73536bf99fd09f73c4fae8";
    sha256 = "1dydafi2fxpzp40nldj6phgis6h3r4gmyr3p2lg7qhn5fh4wi2wm";
  };
  libraryHaskellDepends = [
    base base64-string blaze-builder bytestring case-insensitive
    conduit crypto-conduit http-conduit mtl pureMD5 resourcet
    transformers utf8-string
  ];

  # TODO (BvD): The test-suite doesn't configure currently because of outdated
  # dependencies, so we disable it for now.
  #testHaskellDepends = [ base directory doctest Glob hlint ];
  doCheck = false;

  description = "HTTP Basic and Digest Authentication for http-client";
  license = stdenv.lib.licenses.bsd3;
}
