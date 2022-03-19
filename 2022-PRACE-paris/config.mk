SINGLE_AMPLS = \
	lisp/t-1.dot \
	lisp/t-1.svg \
	lisp/t-2.dot \
	lisp/t-2.svg \
	lisp/t-3.dot \
	lisp/t-3.svg \
	lisp/t-4.dot \
	lisp/t-4.svg \
	lisp/t-5.dot \
	lisp/t-5.svg \

$(SINGLE_AMPLS): lisp/tn.lisp
	cd $(@D) && sbcl --script $(notdir $<)

all: \
	tex/vasp-ctf.pdf \
	$(SINGLE_AMPLS) \

