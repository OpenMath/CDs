DIRS = Official contrib
INSTALL = ../../OpenMath.github.io/sts

all install::
	@for d in $(DIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done 	
