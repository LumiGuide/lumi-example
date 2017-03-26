{ mkDerivation, fetchgit, aeson, attoparsec, base, base-compat
, base64-bytestring, bytestring, deepseq, exceptions
# Dependencies of ghcjs' version of servant-client:
, ghcjs-base ? null
# , ghcjs-prim ? null
, case-insensitive ? null
, hspec
, http-api-data, http-client, http-client-tls, http-media
, http-types, HUnit, mockery, mtl, network, network-uri, process
, QuickCheck, safe, servant, servant-server, stdenv
, string-conversions, text, transformers, transformers-compat, wai
, warp
}:

mkDerivation {
  pname = "servant-client";
  version = "0.9";
  src = (fetchgit {
    url = "https://github.com/LumiGuide/servant.git";
    rev = "798d9e896726aac7e4a279d78c840772b589137f";
    sha256 = "0ziifdz57mxcw0b83p7yvfan8h9kr9vm5p4dwzzkdg3qkam4k640";
  }) + "/servant-client";
  libraryHaskellDepends = [
    aeson attoparsec base base64-bytestring bytestring exceptions
    ghcjs-base
    # ghcjs-prim
    case-insensitive
    http-api-data http-client http-client-tls http-media http-types mtl
    network-uri safe servant string-conversions text transformers
    transformers-compat
  ];
  testHaskellDepends = [
    aeson base base-compat base64-bytestring bytestring deepseq
    exceptions
    ghcjs-base
    # ghcjs-prim
    case-insensitive
    hspec http-api-data http-client http-media http-types mtl
    HUnit mockery network network-uri process QuickCheck safe servant
    servant-server string-conversions text transformers
    transformers-compat wai warp
  ];
  doCheck = false;
  homepage = "http://haskell-servant.readthedocs.org/";
  description = "automatical derivation of querying functions for servant webservices";
  license = stdenv.lib.licenses.bsd3;
}
