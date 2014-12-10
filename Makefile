XSLTPROC=/usr/bin/xsltproc

FOP_BASE=/usr/local/Cellar/fop/1.1/libexec
FOP=$(FOP_BASE)/fop
FOP_CONF=$(FOP_BASE)/conf/fop.xconf

XSL_BASE=/usr/local/Cellar/docbook-xsl/1.78.1/docbook-xsl
XSL_HTML=$(XSL_BASE)/html/docbook.xsl
XSL_FO=$(XSL_BASE)/fo/docbook.xsl
XSL_EPUB=$(XSL_BASE)/epub/docbook.xsl

KINDLE_GEN=/Users/amin/tools/KindleGen_Mac_i386_v2_9/kindlegen

MAIN=src/main/xml/book.xml
DIST=target/IntroToRx
#TARGETS=$(DIST).html

all: html

html: $(MAIN) $(XSL_HTML)
	@$(XSLTPROC) --xinclude -o $(DIST).html $(XSL_HTML) $(MAIN)

pdf: $(MAIN) $(XSL_FO)
	@$(XSLTPROC) --xinclude -o $(DIST).fo $(XSL_FO) $(MAIN)
	@$(FOP) -c $(FOP_CONF) -fo $(DIST).fo -pdf $(DIST).pdf
	
epub: $(MAIN) $(XSL_EPUB)
	@$(XSLTPROC) --xinclude -o $(DIST).epub $(XSL_EPUB) $(MAIN)
	
mobi: $(DIST).html
	$(KINDLE_GEN) $(DIST).html

target:
	@mkdir target

view: html
	open $(DIST).html

clean:
	@rm -rf target
