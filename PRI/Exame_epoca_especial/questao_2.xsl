<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
<!--    Desenvolva uma stylesheet XSL para extrair todas as chaves 
        (o atributo ID de BIBLIOENTRY) e apre- sent ́a-las por ordem
        alfab ́etica.
-->    
    
    <xsl:output method="html" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
            </head>
            
            <body>
                <ul>
                  <xsl:apply-templates select="//BIBLIOENTRY">
                    <xsl:sort select="."></xsl:sort>
                </xsl:apply-templates>
                </ul>
            </body>    
        </html>
    </xsl:template>
    
    <xsl:template match="BIBLIOENTRY">
        <li><xsl:value-of select="@ID"></xsl:value-of></li>
    </xsl:template>
</xsl:stylesheet>