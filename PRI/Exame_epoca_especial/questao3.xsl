<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
<!-- Quest ̃ao 3 Desenvolva uma stylesheet XSL para
        apresentar os registos bibliogr ́aficos por ordem alfab ́etica de 
        chave.-->
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
   Title :  <p><xsl:value-of select="TITLE"></xsl:value-of></p>
   Authorgroup : <ul>
                   <xsl:for-each select="AUTHORGROUP/AUTHOR">
                     <li>  <xsl:value-of select="."></xsl:value-of></li>
                   </xsl:for-each> 
       
                </ul>   
        
        <hr/>
    </xsl:template>

    
</xsl:stylesheet>