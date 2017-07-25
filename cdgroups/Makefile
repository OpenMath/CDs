BASE = ..
LIB = $(BASE)/lib
SITE = $(BASE)/../OpenMath.github.io
INSTALL = $(SITE)/cdgroups

CDG = $(shell ls *.cdg)
HTML = $(CDG:%.cdg=%.html)
SAXON = java -jar $(LIB)/saxon/saxon9he.jar

all: $(HTML) index.md

$(HTML): %.html: %.cdg $(LIB)/xsl/cdgroup.xsl
	$(SAXON) -o:$@ $< $(LIB)/xsl/cdgroup.xsl 

install: all
	mkdir -p $(INSTALL) || true
	cp *.html *.cdg index.md $(INSTALL)

index.md:
	@echo '---' > $@
	@echo 'layout: page' >> $@
	@echo 'title: OpenMath Content Dictionaries - CD Groups' >> $@
	@echo '---' >> $@
	@for d in $(CDG); do echo "* [$$d]($$d)" | sed -e 's/cdg)/html)/'  >> $@; done

echo:
	@echo $(HTML)
