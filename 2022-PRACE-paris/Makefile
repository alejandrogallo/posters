SINGLE_AMPLS = \
	lisp/t-1.svg \
	lisp/t-2.svg \
	lisp/t-3.svg \
	lisp/t-4.svg \
	lisp/t-5.svg \

SVG_LISP_FILES = \
	$(SINGLE_AMPLS) \
	lisp/electrons.svg \
	lisp/fcc.svg \
	lisp/particle.svg \
	lisp/t2.svg \
	lisp/t3.svg \
	lisp/triples1.svg \
	lisp/v@c-pp-hp-t1-t2.svg \
	lisp/vabij.svg

TEXFILES = $(wildcard tex/*.tex)
PDF_TEXFILES = $(patsubst %.tex,%.pdf,$(TEXFILES))
PNG_TEXFILES = $(patsubst %.tex,%.png,$(TEXFILES))

all: \
	tex/vasp-ctf.pdf \
	$(SINGLE_AMPLS) \
	$(PNG_TEXFILES) \
	$(SVG_LISP_FILES) \

%.png: %.pdf
	convert -density 500 $< $@

$(SINGLE_AMPLS): lisp/tn.lisp
	cd $(@D) && sbcl --script $(notdir $<)


%.pdf: %.tex
	tectonic $<

%.dot %.svg: %.lisp
	cd $(@D) && sbcl --script $(notdir $<)

clean:
	rm -v tex/*.pdf tex/*png lisp/*svg lisp/*dot

.PHONY: all clean
