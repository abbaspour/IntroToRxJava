XSLTPROC=/usr/bin/xsltproc

FOP_BASE=/usr/local/Cellar/fop/1.1/libexec
FOP=$(FOP_BASE)/fop
FOP_CONF=$(FOP_BASE)/conf/fop.xconf

XSL_BASE    :=  /usr/local/Cellar/docbook-xsl/1.78.1/docbook-xsl
XSL_HTML    :=  $(XSL_BASE)/html/docbook.xsl
XSL_FO      :=  $(XSL_BASE)/fo/docbook.xsl
XSL_EPUB    :=  $(XSL_BASE)/epub/docbook.xsl
XSL_XSLTHL  :=  $(XSL_BASE)/highlighting/xslthl-config.xml
XSL_WEBHELP :=  $(XSL_BASE)/webhelp/xsl/webhelp.xsl

KINDLE_GEN=/Users/amin/tools/KindleGen_Mac_i386_v2_9/kindlegen

MAIN=xml/book.xml
STYLE=style/style.xsl
DIST=target/book

XSLTHL_ARGS=-Dxslthl.config="file://$(XSL_XSLTHL)"

SAXON_CP=lib/xercesImpl-2.9.1.jar:lib/saxon-6.5.5.jar:lib/docbook-xsl-saxon_1.00.jar:lib/xslthl-2.1.3.jar
SAXON_ARGS=-Dorg.apache.xerces.xni.parser.XMLParserConfiguration=org.apache.xerces.parsers.XIncludeParserConfiguration
SAXON=java -client -cp $(SAXON_CP) $(SAXON_ARGS) $(XSLTHL_ARGS) com.icl.saxon.StyleSheet

all: html

html-xsltproc: $(MAIN) $(XSL_HTML)
	@$(XSLTPROC) --xinclude -o $(DIST).html $(XSL_HTML) $(MAIN)
	@$(XSLTPROC) --xinclude -o $(DIST).html $(STYLE) $(MAIN)

html: $(MAIN) $(XSL_HTML)
	@$(SAXON) -o $(DIST).html $(MAIN) $(STYLE)
	@mkdir -p target/img
	@cp img/* target/img

pdf: $(MAIN) $(XSL_FO)
	@$(XSLTPROC) --xinclude -o $(DIST).fo $(XSL_FO) $(MAIN)
	@$(FOP) -c $(FOP_CONF) -fo $(DIST).fo -pdf $(DIST).pdf
	
epub: $(MAIN) $(XSL_EPUB)
	@$(XSLTPROC) --xinclude -o $(DIST).epub $(XSL_EPUB) $(MAIN)
	
mobi: $(DIST).html
	$(KINDLE_GEN) $(DIST).html

webhelp: $(MAIN) $(XSL_WEBSITE)
	@$(SAXON) -o target/site.html $(MAIN) $(XSL_WEBHELP)
	@cp -r common docs
	@mkdir -p docs/img
	@cp img/* docs/img

dot: gv/event-flow.dot
	dot -Tpng -o img/event-flow.png gv/event-flow.dot

publish: webhelp
	@cp -rv docs/* ../IntroToRxJava-website/

target:
	@mkdir target

view: html
	open $(DIST).html

clean:
	@rm -rf target docs
