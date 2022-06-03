poster.pdf: poster.tex bilder/cc4s-flowchart.pdf

%.pdf: %.tex
	pdflatex $*.tex

bilder/%.pdf: bilder/%.asy
	cd bilder; asy -f pdf $*.asy
