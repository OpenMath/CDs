DIRS = cd sts

all: 
	@for d in $(DIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done 	

install: all 
	@for d in $(DIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done 	
