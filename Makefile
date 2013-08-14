all: Makefile.coq
	$(MAKE) -f Makefile.coq all

Makefile.coq: arguments.txt Makefile
	coq_makefile -f arguments.txt -o Makefile.coq