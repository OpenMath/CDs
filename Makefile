DIRS = cd cdgroups sts contrib
OCD = $(shell ls cd/*/*.ocd contrib/cd/*.ocd)
CDS = $(OCD:%.ocd=%)
SAXON = java -jar lib/saxon/saxon9he.jar
INSTALL = ../OpenMath.github.io

all: cdnames.md symbols.md
	@for d in $(DIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done 	

install: all 
	@for d in $(DIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done 	
	cp cdnames.md cdnamess.md symbols.md $(INSTALL)

cds.xml: $(OCD)
	@echo "<CDS>" > cds.xml
	@for d in $(OCD); do\
	   echo "<OCD path=\"$$d\">" >> cds.xml &&\
	   cat $$d >> cds.xml &&\
	   echo "</OCD>" >> cds.xml;\
	done
	@echo "</CDS>" >> cds.xml
	sed -E s/.*version=\"1.0\".*//g cds.xml > cds.xml.r
	mv cds.xml.r cds.xml

cdnames.md: cds.xml lib/xsl/cdnames.xsl
	$(SAXON) -o:$@ $< lib/xsl/cdnames.xsl 
	$(SAXON) -o:cdnamess.md $< lib/xsl/cdnamess.xsl 

symbols.md: cds.xml lib/xsl/index.xsl
	$(SAXON) -o:$@ $< lib/xsl/index.xsl 


echo:
	@echo $(OCD)
