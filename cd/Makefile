DIRS = Official experimental contrib
BASE = ..
INSTALL = $(BASE)/../OpenMath.github.io/cd

all:
	@for d in $(DIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done 	

install: all 
	@for d in $(DIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done 	
	cp omcd.css $(INSTALL)
