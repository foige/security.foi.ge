{
  description = "FOI Security — development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        python = pkgs.python312;
        pythonPkgs = python.pkgs;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            python
            pkgs.uv
            pkgs.gh
            pkgs.cairo
            pkgs.freetype
            pkgs.libffi
            pkgs.pango
            pkgs.gdk-pixbuf
            pkgs.glib
          ];

          env.DYLD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
            pkgs.cairo
            pkgs.freetype
            pkgs.libffi
            pkgs.pango
            pkgs.gdk-pixbuf
            pkgs.glib
          ];

          env.UV_PYTHON = "${python}/bin/python";
          env.GH_CONFIG_DIR = "./.gh";
        };
      });
}
