{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell rec {

  buildInputs = with pkgs; [
    python3
    python3Packages.matplotlib
    python3Packages.pyyaml
    asymptote
    gnuplot
    inkscape
  ];

  shellHook = ''
  '';

}
