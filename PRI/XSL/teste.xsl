<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"

    exclude-result-prefixes="xs"
    version="2.0">
    
    
    
    
    <xsl:template match="section">
        <h2>
            <xsl:value-of select="title">
                
            </xsl:value-of>
        </h2>
    </xsl:template>
    
    
    <xsl:template match="p:p">
        <p>
            
            <xsl:value-of select=".">
                
            </xsl:value-of>
        </p>
        
        
    </xsl:template>
    <xsl:template match="text()" priority="1">
        
        
    </xsl:template>
</xsl:stylesheet>