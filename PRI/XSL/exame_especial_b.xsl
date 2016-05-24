<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                
            </head>   
            <body>
            <ul>        
                <xsl:for-each select="//BIBLIOENTRY">
                    <xsl:sort select="@ID"/>
                    <li>
                        ID: <xsl:value-of select="@ID"></xsl:value-of>
                    </li>
                </xsl:for-each>
                
            </ul>        
           </body>
        </html>
        
    </xsl:template>
</xsl:stylesheet>