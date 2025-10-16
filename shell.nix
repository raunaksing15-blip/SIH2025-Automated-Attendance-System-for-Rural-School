
{ pkgs ? import <nixpkgs> {} }:

let
  dev = import ./attendance-backend/.idx/dev.nix { inherit pkgs; };
in
pkgs.mkShell {
  buildInputs = dev.packages;
}
