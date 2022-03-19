-include config.mk

%.pdf: %.tex
	tectonic $<

%.dot %.svg: %.lisp
	cd $(@D) && sbcl --script $(notdir $<)
