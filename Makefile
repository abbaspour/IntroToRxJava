TARGETS=main.html
XSLTPROC=/usr/bin/xsltproc
FOP=/usr/local/Cellar/fop/1.1/bin/fop

XSL_BASE=/usr/local/Cellar/docbook-xsl/1.78.1/docbook-xsl
XSL_HTML=$(XSL_BASE)/html/docbook.xsl
XSL_FO=fo/docbook.xsl
XSL_EPUB=$(XSL_BASE)/epub/docbook.xsl
KINDLE_GEN=/Users/amin/tools/KindleGen_Mac_i386_v2_9/kindlegen

MAIN=src/main/xml/book.xml
DIST=target/main

all: $(TARGETS)

html: $(MAIN) $(XSL_HTML)
	@$(XSLTPROC) --xinclude -o $(DIST).html $(XSL_HTML) $(MAIN)

pdf: $(MAIN) $(XSL_FO)
	@$(XSLTPROC) --xinclude -o $(DIST).fo $(XSL_FO) $(MAIN)
	@$(FOP) -c fo/fop.xconf -fo $(DIST).fo -pdf $(DIST).pdf
	
epub: $(MAIN) $(XSL_EPUB)
	@$(XSLTPROC) --xinclude -o $(DIST).epub $(XSL_EPUB) $(MAIN)
	
mobi: $(DIST).html
	@$(KINDLE_GEN) $(DIST).html

clean:
	rm -f target/*.html target/*.fo target/*.pdf target/*.epub target/*.fotmp
