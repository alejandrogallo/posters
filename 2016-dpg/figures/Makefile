FILES=$(wildcard *.asy)
PDF_TO_BUILD=$(patsubst %.asy,%.pdf,$(FILES))


%.pdf: %.asy
	echo Compiling $<
	asy -f pdf $<
