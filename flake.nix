{
  # This is a template created by `hix init`
  inputs = {
    haskellNix.url = "github:input-output-hk/haskell.nix";
    nixpkgs.follows = "haskellNix/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, haskellNix }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      hixProject = pkgs.haskell-nix.cabalProject' {
        compiler-nix-name = "ghc902";
        src = ./.;
      };
      overlays = [ haskellNix.overlay ];
      pkgs = import nixpkgs { inherit system overlays; inherit (haskellNix) config; };
      flake = hixProject.flake {};
    in flake);
}
