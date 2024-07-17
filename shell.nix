{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  buildInputs = [
    pkgs.just
    pkgs.nixpkgs-fmt
  ];
}
