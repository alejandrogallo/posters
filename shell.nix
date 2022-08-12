{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell rec {

  buildInputs = with pkgs; [
    sbcl
    tectonic
    texlive.combined.scheme-full
    imagemagick
    gnuplot
    graphviz
    python3
    python3Packages.matplotlib
    python3Packages.pyyaml
    python3Packages.numpy

    gnumake
    coreutils-full
    inkscape
    asymptote
  ];

  shellHook = ''
  '';

}
