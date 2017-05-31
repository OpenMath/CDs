DIRS = Official contrib
INSTALL = ../site/sts

all install::
	@for d in $(DIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done 	
