<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="html" indent="yes">
        
    </xsl:output>
    
    <xsl:template match="/">
        <html>
            <head>
                
            </head>
            
            <body>
                <ul>
             <xsl:for-each select="//elemento">
                <xsl:variable name="elemento" select="."></xsl:variable>
                <xsl:variable name="x" select="5"></xsl:variable>
                    
                    <xsl:if test="$elemento>$x">
                    <li>
                        <xsl:value-of select="."></xsl:value-of>
                    </li>
                    
                </xsl:if>
             </xsl:for-each>        
                </ul>
                
            </body>
            
        </html>   
        
        
        
    </xsl:template>
    
    
</xsl:stylesheet>