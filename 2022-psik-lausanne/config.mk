BUILD_DIR = .build
PDFLATEX = xelatex
PY = python3
VIEW =

main.pdf: $(patsubst %.svg,%.pdf,$(shell find figures/ -name '*.svg'))

%.pdf: %.svg
	inkscape --export-type=pdf $<
