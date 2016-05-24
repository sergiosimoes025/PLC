<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="skos" version="2.0"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
    
    <xsl:output method="html" indent="yes"/>
    
    
    <xsl:key name="concepts" match="skos:Concept" use="@rdf:about"></xsl:key>
    
    <xsl:template match="/">
        <xsl:apply-templates select="//skos:Concept">
            <xsl:sort select="skos:prefLabel"></xsl:sort>
        </xsl:apply-templates>
        
        
    </xsl:template>
    <xsl:template match="skos:Concept">
       
        <li>
            <xsl:value-of select="skos:prefLabel"/>
            
            <xsl:text> - </xsl:text>
         <xsl:apply-templates select="skos:broader" mode="desc"/>
         <xsl:value-of select="skos:prefLabel"/>
        </li>   
    </xsl:template>
    
    <xsl:template match="skos:broader" mode="desc">
        <xsl:apply-templates select="key('concepts',@rdf:resource)/skos:broader" mode="desc"/>/
            
        <xsl:value-of select="key('concepts',@rdf:resource)/skos:prefLabel"></xsl:value-of>
         
    </xsl:template>
    
    
    
</xsl:stylesheet>