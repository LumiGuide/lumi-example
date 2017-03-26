{ mkDerivation
, stdenv
, fetchurl

, customNodePackages
, writeTextFile

# Haskell libraries
, either
, fetchgit
, ghcjs-ffiqq
, lens
, mtl
, pretty-show
, text
, time
, transformers
}:

let src = fetchgit {
      url = "https://github.com/LumiGuide/blaze-react.git";
      rev = "6fdc409ecc4cc2893810e184faed131a277a697b";
      sha256 = "0cy18ac9a29yksk56p4nz692hkkd8hkpx5idwpnh6dhxr1k5nq1n";
    };

    version = "0.1.0.0";

    reactjsBindings = stdenv.mkDerivation {
      name = "reactjs-bindings-${version}";
      inherit src;
      buildInputs = [
        customNodePackages.browserify
      ];
      buildCommand = ''
        source $stdenv/setup
        cp -r $src/reactjs-bindings .
        chmod +w -R reactjs-bindings
        cd reactjs-bindings
        ln -s ${customNodePackages."react-0.13.2"}/lib/node_modules
        mkdir $out
        browserify lib.require.js -o $out/lib.js
      '';
    };
in mkDerivation (rec {
  inherit src;
  inherit version;
  pname = "blaze-react";
  isLibrary = true;
  isExecutable = false;
  buildDepends = [
    either
    ghcjs-ffiqq
    lens
    mtl
    pretty-show
    text
    time
    transformers
  ];

  preConfigure = ''
    ln -s ${reactjsBindings}/lib.js reactjs-bindings/lib.js
  '';

  description = "Experimental ReactJS bindings for GHCJS";
  license = stdenv.lib.licenses.mit;
})
