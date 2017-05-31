DIRS = Official experimental contrib
BASE = ..
INSTALL = $(BASE)/site

all:
	@for d in $(DIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done 	

install: all 
	@for d in $(DIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done 	
	cp omcd.css $(INSTALL)
