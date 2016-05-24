<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <!-- Desenvolva uma stylesheet XSL para criar o  ́ındice de autores. 
        O  ́ındice de autores  ́e uma lista de pares: o primeiro elemento 
        do par  ́e o autor, o segundo  ́e a lista de chaves correspondentes
        aos documentos relacionados com esse autor.
A stylesheet dever ́a gerar um documento XML como resultado. 
Este documento dever ́a ser gerado de acordo com a estrutura
abstracta descrita no par ́agrafo anterior. Apresente tamb ́em esse DTD.-->
    
    <xsl:template match="/">
        <xsl:result-document href="indice.xml">
            <indice_autores>
            <xsl:apply-templates select="//AUTHOR[not(.=following::AUTHOR)]">
                <xsl:sort select="."></xsl:sort>
            </xsl:apply-templates>    
                
            </indice_autores>
            
            
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="AUTHOR">
        <xsl:variable name="autor" select="."></xsl:variable>
        <author><xsl:value-of select="."></xsl:value-of>
        </author>
       
        <list_keys>
            <xsl:for-each select="../../../../BIBLIODIV//BIBLIOENTRY[descendant::AUTHOR=$autor]">
                <key><xsl:value-of select="@ID"></xsl:value-of></key>
            </xsl:for-each>
        </list_keys>
        
        
        
    </xsl:template>
    
</xsl:stylesheet>