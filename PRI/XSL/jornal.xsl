<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Jornal do Perez</title>
                
            </head>
            <body>
             <xsl:apply-templates select="//cabeçalho"/>
             <h2>Indice de Secções</h2>   
             <ul>   
             <xsl:apply-templates mode="indice" select="//secção"/>
             </ul>   
             <hr/>
             <xsl:apply-templates  select="//secção"/>  
                
                
                
            </body>
        </html>
        
        
    </xsl:template>
    
    
    
    
    <xsl:template match="cabeçalho">
        <h2><xsl:value-of select="edição"></xsl:value-of></h2>
        <h3><xsl:value-of select="data"></xsl:value-of></h3>
        
    </xsl:template>
    
    <xsl:template mode="indice" match="secção">
        <li>
            <a href="#{generate-id(@id)}"><xsl:value-of select="@id"/>
            </a>
        </li>
    </xsl:template>
    
    
    <xsl:template match="secção">
        <a name="{generate-id(@id)}"><h2><xsl:value-of select="@id"/></h2></a>
        <br/>
        <ul>
            <hr/>
           <xsl:for-each select="artigo">
               <h3><xsl:value-of select="@id"/></h3>
               <h4><xsl:value-of select="titulo"></xsl:value-of></h4>
               <p><xsl:value-of select="p/nome_pessoa"></xsl:value-of></p>
               
           </xsl:for-each> 
        </ul>   
        <hr/>
        <br/>
    </xsl:template>
    
    
</xsl:stylesheet>