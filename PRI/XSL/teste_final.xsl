<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="html" indent="yes"></xsl:output>
    
    <xsl:template match="/">
        <html>
            <head>
                
            </head>
            
            <body>
                <h1>Indice Entradas </h1>
                <ul>
                   <xsl:for-each select="//receita">
                       <li>
                           <a href="#{generate-id()}">
                               <xsl:value-of select="nome"></xsl:value-of></a>
                       </li>
                       
                       
                   </xsl:for-each>
                    
                    
                </ul>
                
                
                <ul>
                    
               <xsl:apply-templates select="//receita"></xsl:apply-templates> 
                </ul>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="receita">
        <li> <xsl:value-of select="@tipo"></xsl:value-of></li>
        
        <ul>
            <li>
            NOME :
                
               <a name="{generate-id()}"><xsl:value-of select="nome"></xsl:value-of>
               </a>
            </li>
            
       </ul>
        
        <xsl:for-each select="ingredientes/ingrediente">
            <li>
              <xsl:value-of select="nome"></xsl:value-of>  
                
            </li>    
        </xsl:for-each>
        
    </xsl:template>
    
    
    
</xsl:stylesheet>