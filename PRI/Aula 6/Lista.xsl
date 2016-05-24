<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:my="http://jcr.di.uminho.pt"
    version="2.0">
    
    <xsl:template match="/">
        <xsl:call-template name="somaLista">
            <xsl:with-param name="l" select="lista"/>
        </xsl:call-template>
        <xsl:value-of select="my:somaLista(lista)"/>
    </xsl:template>
    
    <xsl:function name="my:somaLista">
        <xsl:param name="l"/>
        <xsl:choose>
            <xsl:when test="$l/elem">
                <xsl:value-of select="$l/elem + my:somaLista($l/lista)"/>
            </xsl:when>
            <xsl:otherwise>0</xsl:otherwise>
        </xsl:choose>
        
    </xsl:function>
        
        <xsl:template name="somaLista">
            <xsl:param name="l"/>
            
            <xsl:choose>
                <xsl:when test="$l/elem">
                    <xsl:variable name="x" select="$l/elem"/>
                    <xsl:variable name="xs">
                        <xsl:call-template name="somaLista">
                            <xsl:with-param name="l" select="$l/lista"/>
                        </xsl:call-template>
                    </xsl:variable>
                    <xsl:value-of select="$x+$xs"/>
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
    </xsl:template>
</xsl:stylesheet>