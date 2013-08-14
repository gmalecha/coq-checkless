all: Makefile.coq
	@ $(MAKE) -f Makefile.coq all

clean: Makefile.coq
	@ $(MAKE) -f Makefile.coq clean
	@ rm Makefile.coq

Makefile.coq: arguments.txt Makefile
	@ coq_makefile -f arguments.txt -o Makefile.coq