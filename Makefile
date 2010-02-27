# Basic Windows vs Unix shell configuration: $/ is the separator in file paths.

NAME=rtv2kml

ifdef ComSpec
    OS=Windows
    # Ugly way to get a single \ into a variable
    /=$(shell echo \)
else
    OS=$(shell uname -o 2> /dev/null || uname -s)
    /=/
endif

PREFIX=$/usr$/local
BIN=$(PREFIX)$/bin

MKDIR=mkdir -p
CP=cp

ifeq ($(OS),Cygwin)
    EXEEXT=.exe
else ifeq ($(OS),Windows)
    EXEEXT=.exe
    MKDIR=mkdir
    CP=copy/y
endif


EXEDIR=Compiled$/$(OS)

SCRIPTS=$(NAME).pl
EXE=$(NAME)$(EXEEXT)

all:

$(EXEDIR)$/$(EXE): $(SCRIPTS)
	pp -o "$(EXEDIR)$/$(EXE)" $(SCRIPTS)

install: all check install_perl

install_perl: $(BIN)
	$(CP) $(SCRIPTS) "$(BIN)"

install_bin: all compile $(BIN)
	$(CP) "$(EXEDIR)$/$(EXE)" "$(BIN)"

compile: check $(EXEDIR) $(EXEDIR)$/$(EXE)

uninstall: uninstall_bin uninstall_lib

uninstall_bin:
	cd "$(BIN)" && rm -f $(SCRIPTS) && rm -f $(EXE)
	
doc: $(SCRIPTS)
	.$/make_doc.sh $(SCRIPTS)

check:
	.$/checkModules.pl $(SCRIPTS)

$(EXEDIR):
	$(MKDIR) "$(EXEDIR)"

$(BIN):
	$(MKDIR) "$(BIN)"

