{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell rec {

  buildInputs = with pkgs; [
    sbcl
    tectonic
    texlive.combined.scheme-medium
    gnuplot
    graphviz
    asymptote
    python3
    python3Packages.matplotlib
    python3Packages.pyyaml
  ];

  shellHook = ''
  '';

}
