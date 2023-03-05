{
  description = "Chess bitboards in zig";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";

        buildInputs = with pkgs; [
          zig
        ];
      in
      rec {
        # `nix build`
        packages = {
          bitboard-zig = pkgs.stdenv.mkDerivation {
            inherit buildInputs;
            name = "bitboard-zig";
            src = self;

            installPhase = ''
              zig build
            '';
          };
        };
        defaultPackage = packages.bitboard-zig;

        # `nix run`
        apps.bitboard-zig = utils.lib.mkApp {
          drv = packages.bitboard-zig;
        };
        defaultApp = apps.bitboard-zig;

        # `nix develop`
        devShell = pkgs.mkShell {
          inherit buildInputs;
        };
      });
}
