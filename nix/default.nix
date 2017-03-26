# Some of our 3rd-party dependencies are not in the nixpkgs package set. So we
# provide this function which can be used as a packageOverrides function. It
# will extend or override the package set from nixpkgs.
#
# The rule is that the packages provided here should be 3rd-party packages /
# non-LumiGuide specific packages. All packages specific to LumiGuide should be
# put in ./lumi.nix.
#
# The intention for the extensions placed in this file is that they should be
# added to nixpkgs in the future.
super:
let self   = super.pkgs;
    haskellOverrides         = import ./haskell/default  self;
    profiledHaskellOverrides = import ./haskell/profiled self;
    ghcjsHaskellOverrides    = import ./haskell/ghcjs    self;
in rec {

  # We extend lib with our own handy library functions.
  lib = super.lib // import ./lib.nix super;

  # We override the default Haskell package set and the GHCJS package set with
  # our own extensions / overrides defined in ./haskell.
  haskellPackages = super.haskell.packages.ghc802.override haskellOverrides;
  haskell = super.haskell // {
    packages = super.haskell.packages // {
      ghcjs = super.haskell.packages.ghcjsHEAD.override ghcjsHaskellOverrides;
    };
  };
  profiledHaskellPackages = self.haskellPackages.override profiledHaskellOverrides;

  opencv3 = super.opencv3.override {
    enableIpp = true;
    enableEXR = false;
  };

  python = super.python.override {packageOverrides = import ./python-packages.nix super;};

  # This functions returns a derivation which results in an executable BASH
  # script stored in /nix/store/...-$name/bin/$name. The BASH script is
  # statically checked against errors using the ShellCheck tool.
  #
  # If some check causes your build to fail and you know your script is correct
  # you can exclude that check by passing its code in the excludeCodes list.
  #
  # See https://github.com/koalaman/shellcheck/wiki for documentation on each check.
  writeCheckedBashScriptBin = name: excludeCodes: text: with self;
    let excludeCodesArg = lib.concatStringsSep "," excludeCodes; in
    runCommand name {
      excludes = lib.optionalString (builtins.length excludeCodes > 0) ''--exclude ${excludeCodesArg}'';
      inherit name text;
    } ''
      (cat <<EOI
      #!${bash}/bin/bash
      $text
      EOI
      ) > "$name"

      chmod +x "$name"

      ${haskellPackages.ShellCheck}/bin/shellcheck $excludes "$name"

      mkdir -p "$out/bin"
      mv "$name" "$out/bin/$name"
    '';
}
