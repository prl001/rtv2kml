PREFIX=/usr/local
BIN=$(PREFIX)/bin
LIB=$(PREFIX)/lib/perl

SCRIPTS=rtv2kml.pl

all:

install: all install_lib install_bin

install_lib:

install_bin:
	mkdir -p '$(BIN)'
	cp $(SCRIPTS) '$(BIN)'

uninstall: uninstall_bin uninstall_lib

uninstall_bin:
	cd '$(BIN)' && rm -f $(SCRIPTS)
	
uninstall_lib:
	
doc::
	./make_doc.sh $(SCRIPTS)
