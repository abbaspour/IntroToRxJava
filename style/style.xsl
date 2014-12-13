<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xslthl="http://xslthl.sf.net"
                exclude-result-prefixes="xslthl"
                version="1.0">

    <xsl:import href="/usr/local/Cellar/docbook-xsl/1.78.1/docbook-xsl/html/docbook.xsl"/>
    <xsl:import href="/usr/local/Cellar/docbook-xsl/1.78.1/docbook-xsl/html/highlight.xsl"/>

    <xsl:param name="html.stylesheet" select="../css/ubuntu.css"/>
    <xsl:param name="use.extensions" select="1"/>
    <xsl:param name="textinsert.extension" select="1"/>
    <xsl:param name="generate.toc" select="'book toc'"/>
    <xsl:param name="highlight.source" select="1"/>

    <xsl:template match='xslthl:keyword'>
        <b class="color: green"><xsl:apply-templates/></b>
    </xsl:template>

</xsl:stylesheet>