<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="html" indent="yes"></xsl:output>
    
    <xsl:template match="/">
        <xsl:result-document href="index.html">
        <html>
            <head>
                
            </head>
            
            <body>
                <h2> Indice de Obras</h2>
                    <ul>
                        <xsl:apply-templates mode="indice_obras" select="//obra">
                            <xsl:sort></xsl:sort>
                        </xsl:apply-templates>
                     </ul>    
                <h2>Indice de Compositores</h2>
                    <ul>
                <xsl:apply-templates mode="indice_compositores" select="//compositor[not(.=following::compositor)]">
                    <xsl:sort></xsl:sort>
                </xsl:apply-templates>
                <h2> Obras em papel(para digitalizar)</h2>
                    </ul>   
                    <ul>   
                <xsl:apply-templates mode="indice_obras_em_papel" select="//obra"></xsl:apply-templates>
                   </ul>
                
                <xsl:apply-templates select="//obra"></xsl:apply-templates>
            </body>
        </html>
        </xsl:result-document>
        
       
        
    </xsl:template>
    
    <xsl:template mode="indice_obras" match="obra">
        
       <li><a href="questao4/{@id}.html"><xsl:value-of select="titulo"></xsl:value-of> - (<xsl:value-of select="@id"></xsl:value-of>)</a></li>
   </xsl:template>
    
    
    <xsl:template mode="indice_compositores" match="compositor">
        <li><a href="questao4/{.}.html"><xsl:value-of select="."></xsl:value-of></a></li>
    </xsl:template>
    
    
    
    <xsl:template match="obra">
        <xsl:result-document href="questao4/{@id}.html">
            <html>
                <head>
                    <link rel="stylesheet" type="text/css" href="http://bootswatch.com/flatly/bootstrap.min.css"/>
                    <!-- Latest compiled and minified CSS -->
                    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
                    <!-- Optional theme -->
                    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"/>
                </head>
               
                <body>
                    <h2><xsl:value-of select="titulo"></xsl:value-of></h2>
                    <xsl:call-template name="nav-bar"/>
                </body>
            </html>   
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="nav-bar">
        <xsl:choose>
            <xsl:when test="preceding-sibling::obra">
                <a href="{preceding-sibling::obra[1]/@id}.html"> Anterior</a>
            </xsl:when>
            
        </xsl:choose>
        
        <a href="../index.html">Indice</a>
        
        <xsl:choose>
            <xsl:when test="following-sibling::obra">
                <a href="{following-sibling::obra[1]/@id}.html"> Próximo</a>
            </xsl:when>
        </xsl:choose>
        
    </xsl:template>
    
    
</xsl:stylesheet>