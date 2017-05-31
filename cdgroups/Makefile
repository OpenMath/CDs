BASE = ..
LIB = $(BASE)/lib
SITE = $(BASE)/site
INSTALL = $(SITE)/cdgroups

CDG = $(shell ls *.cdg)
HTML = $(CDG:%.cdg=%.xhtml)
SAXON = java -jar $(LIB)/saxon/saxon9he.jar

all: $(HTML) index.md

$(HTML): %.xhtml: %.cdg $(LIB)/xsl/cdgroup.xsl
	xsltproc -o $@ $(LIB)/xsl/cdgroup.xsl $<

install: all
	mkdir -p $(INSTALL) || true
	cp *.xhtml *.cdg index.md $(INSTALL)

index.md:
	@echo "---\nlayout: page\ntitle: OpenMath Content Dictionaries - CD Groups\n---\n" > $@
	@for d in $(CDG); do echo "* [$$d]($$d)" >> $@; done

echo:
	@echo $(HTML)
