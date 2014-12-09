TARGETS=main.html
XSLTPROC=/usr/bin/xsltproc
FOP=/Users/amin/tools/fop-1.1rc1/fop

XSL_BASE=/Users/amin/tools/docbook-xsl-1.77.1/
XSL_HTML=$(XSL_BASE)/html/docbook.xsl
XSL_FO=fo/docbook.xsl
XSL_EPUB=$(XSL_BASE)/epub/docbook.xsl
KINDLE_GEN=~/tools/kindleGen_Mac_i386_v2_5/KindleGen

MAIN=xml/main.xml
DIST=dist/main

all: $(TARGETS)

html: $(MAIN) $(XSL_HTML)
	@$(XSLTPROC) --xinclude -o $(DIST).html $(XSL_HTML) $(MAIN)

pdf: $(MAIN) $(XSL_FO)
	@$(XSLTPROC) --xinclude -o $(DIST).fo $(XSL_FO) $(MAIN)
	sed -i tmp -E 's/lang.{0,4}="fa"//g' $(DIST).fo
	sed -i tmp -e 's/writing-mode="lr-tb"/writing-mode="rl"/' $(DIST).fo
	sed -i tmp -E 's/<fo:leader [^>]+>//' $(DIST).fo 
	sed -i tmp -E 's/,Symbol,ZapfDingbats//g' $(DIST).fo 
	@$(FOP) -c fo/fop.xconf -fo $(DIST).fo -pdf $(DIST).pdf
	
epub: $(MAIN) $(XSL_EPUB)
	@$(XSLTPROC) --xinclude -o $(DIST).epub $(XSL_EPUB) $(MAIN)
	
mobi: $(DIST).html
	@$(KINDLE_GEN) $(DIST).html

clean:
	rm -f dist/*.html dist/*.fo dist/*.pdf dist/*.epub dist/*.fotmp
