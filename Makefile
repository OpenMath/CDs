DIRS = cd cdgroups sts
OCD = $(shell ls cd/*/*.ocd)
CDS = $(OCD:%.ocd=%)
SAXON = java -jar lib/saxon/saxon9he.jar
INSTALL = ../OpenMath.github.io

all: cdnames.md symbols.md
	@for d in $(DIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done 	

install: all 
	@for d in $(DIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done 	
	cp cdnames.md symbols.md $(INSTALL)

cds.xml: $(OCD)
	@echo "<CDS>" > cds.xml
	@for d in $(OCD); do\
	   echo "<OCD path=\"$$d\">" >> cds.xml &&\
	   cat $$d >> cds.xml &&\
	   echo "</OCD>" >> cds.xml;\
	done
	@echo "</CDS>\n" >> cds.xml
	sed -E s/.*version=\"1.0\".*//g cds.xml > cds.xml.r
	mv cds.xml.r cds.xml

cdnames.md: cds.xml lib/xsl/cdnames.xsl
	xsltproc -o $@ lib/xsl/cdnames.xsl $<

symbols.md: cds.xml lib/xsl/index.xsl
	xsltproc -o $@ lib/xsl/index.xsl $<

echo:
	@echo $(OCD)
