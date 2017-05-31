DIRS = cd cdgroups
OCD = $(shell ls cd/*/*.ocd)
CDS = $(OCD:%.ocd=%)
SAXON = java -jar lib/saxon/saxon9he.jar
INSTALL = site

all: 
	@for d in $(DIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done 	

install: all 
	@for d in $(DIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done 	
	cp *.md $(INSTALL)

cds.xml: $(OCD)
	@echo "<CDS>" > cds.xml
	@for d in $(OCD); do\
	   echo "<OCD path=\"$$d\">" >> cds.xml &&\
	   cat $$d >> cds.xml &&\
	   echo "</OCD>" >> cds.xml;\
	done
	@echo "</CDS>\n" >> cds.xml
	sed -iE s/.*version=\"1.0\".*//g cds.xml

cdnames.md: cds.xml lib/xsl/cdnames.xsl
	xsltproc -o $@ lib/xsl/cdnames.xsl $<

symbols.md: cds.xml lib/xsl/index.xsl
	xsltproc -o $@ lib/xsl/index.xsl $<

echo:
	@echo $(notdir $(CDS))
