<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:key name="autor" match="//BIBLIOENTRY/AUTHORGROUP/AUTHOR" use="FIRSTNAME"/>
    
    <xsl:template match="/">
    
   
    
    
    <html>
        <head>
            
            
        </head>
        
        <body>
            <h1> Indice de Autores </h1>
            <ul>
                <xsl:apply-templates select="//BIBLIOENTRY" ></xsl:apply-templates>
            </ul>
            <h2> Obras </h2>
            <ul>
            <xsl:for-each select="//BIBLIOENTRY/AUTHORGROUP/AUTHOR">
               <li>
                <a name="{generate-id(FIRSTNAME)}">
                    <xsl:value-of select="FIRSTNAME"/>
                </a>
               </li>   
            </xsl:for-each>
            
            </ul>
            
        </body>
        
    </html>
    </xsl:template> 
    
    <xsl:template match="BIBLIOENTRY">
        <xsl:for-each select="AUTHORGROUP/AUTHOR">
           <li> 
               <a href="#{generate-id(FIRSTNAME)}">
                 <xsl:value-of select="FIRSTNAME"/>
                </a>
            </li>
        </xsl:for-each>
        
        
    </xsl:template>
    
    
    
    
    
</xsl:stylesheet>