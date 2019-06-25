
all:
	for i in *; do [ -d $$i ] && (cd $$i && $(MAKE) ) ; done

clean:
	for i in *; do [ -d $$i ] && (cd $$i && $(MAKE) clean) ; done
