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
                <h1> ENTRADAS </h1>
                <ul>        
                   <xsl:for-each select="//BIBLIOENTRY">
                       <li>
                         <a href="#{generate-id(@ID)}">
                               <xsl:value-of select="TITLE"/>
                          </a>
                       </li>
                   </xsl:for-each>
                    
                </ul>
                <br/>
                <br/>
                <hr/>
                <xsl:apply-templates select="//BIBLIOENTRY"></xsl:apply-templates>
                
            </body>
        </html>
        
    </xsl:template>
    
    <xsl:template match="BIBLIOENTRY">
        
        <a style="border:1px solid black; font-family:Arial;color:red;" name="{generate-id(@ID)}">
            <xsl:value-of select="TITLE"/>
        </a>
        
        <h3 style=""> Autores</h3>
        <ul>
        <xsl:for-each select="AUTHORGROUP/AUTHOR">
           <li>
               <xsl:value-of select="FIRSTNAME"></xsl:value-of>
               
               <xsl:value-of select="SURNAME"></xsl:value-of>
           </li>
        </xsl:for-each>
        </ul>
        <hr/>
        <br/>
    </xsl:template>
  
</xsl:stylesheet>