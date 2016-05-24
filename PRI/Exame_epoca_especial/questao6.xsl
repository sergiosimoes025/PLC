<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <!--    Desenvolva uma stylesheet XSL que produza uma vers ̃ao HTML 
        do ficheiro original (o layout fica ao seu crit ́erio), com um
        ́ındice de chaves no in ́ıcio. 
        Este  ́ındice permitir ́a navegar no documento, 
        dando acesso directo a cada uma das entradas; 
        dever ́a tamb ́em existir um link junto de cada
        entrada permitindo regressar ao  ́ındice inicial.-->
    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="/">
        <xsl:result-document href="indice.html">
            <html>
                <head>
                    
                </head>
                <body>
                    <h2>Indice</h2>
                    <ul>
                     <xsl:apply-templates mode="indice" select="//BIBLIOENTRY"/>
                    </ul> 
                    <!-- <a name="Metadata.Workshop">dasdasdasdasdasds,dlç,asd~</a>-->
                    
                </body>
            <xsl:apply-templates select="//BIBLIOENTRY"></xsl:apply-templates>
            </html>
        </xsl:result-document>
        
       
        
   </xsl:template>
    
    <xsl:template match="BIBLIOENTRY" mode="indice">
        <li><a href="questao6/{@ID}.html"><xsl:value-of select="TITLE"></xsl:value-of></a></li>
      <!--  <li><a href="#{@ID}">Teste1</a></li>-->
    </xsl:template>
    
    <xsl:template match="BIBLIOENTRY">
        <xsl:result-document href="questao6/{@ID}.html">
            <html>
                <head>
                </head>
                <body>
                    <h2><xsl:value-of select="TITLE"></xsl:value-of></h2>
                    <a href="../indice.html">Indice</a>
                    
                    <xsl:choose>
                        <xsl:when test="preceding-sibling::BIBLIOENTRY">
                            <a href="{preceding-sibling::BIBLIOENTRY[1]/@ID}.html">Anterior</a>
                        </xsl:when>
                    </xsl:choose>
                    
                    
                    <xsl:choose>
                        <xsl:when test="following-sibling::BIBLIOENTRY">
                            <a href="{following-sibling::BIBLIOENTRY[1]/@ID}.html">Próximo</a>
                        </xsl:when>
                    </xsl:choose>
                    
                </body>   
            </html>
            
            
        </xsl:result-document>
        
        
    </xsl:template>
    
</xsl:stylesheet>