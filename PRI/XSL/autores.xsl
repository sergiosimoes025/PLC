<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="html" indent="yes" ></xsl:output>
    
    <xsl:template match="/">
        <xsl:result-document href="indice.html">
            <html>
                <head>
                    <!-- Latest compiled and minified CSS -->
                    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
                    <!-- Optional theme -->
                    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"/>
                    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
                    <link rel="stylesheet" type="text/css"
                        href="http://bootswatch.com/flatly/bootstrap.min.css"/>
                </head>  
                
                <body>
                    <h2 class="text-center">Lista de autores</h2> 
                    <ul>
                    <xsl:apply-templates mode="indice" select="//autor[not(.=following::autor)]">
                        <xsl:sort select="."></xsl:sort>
                        
                    </xsl:apply-templates>
                       
                   </ul>   
                </body>
                <xsl:apply-templates select="//autor[not(.=following::autor)]">
                    <xsl:sort select="."></xsl:sort>
                </xsl:apply-templates>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    
    <xsl:template mode = "indice" match="//autor[not(.=following::autor)]">
        
        <li class="text-center"><a href="sites/{.}.html"><xsl:value-of select="."></xsl:value-of></a>
        </li>
    </xsl:template>
    
    
    <xsl:template match="autor">
       <xsl:result-document href="sites/{.}.html">
            <html>
                <head>
                    <link rel="stylesheet" type="text/css" href="http://bootswatch.com/flatly/bootstrap.min.css"/>
                    <!-- Latest compiled and minified CSS -->
                    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
                    <!-- Optional theme -->
                    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"/>
                 </head>
                <xsl:variable name="nome_autor" select="."></xsl:variable>
                <body>
                    <h2>Fotos de <xsl:value-of select="$nome_autor"></xsl:value-of></h2>
                    <ul>
                        <xsl:for-each select="../..//foto[child::autor=$nome_autor]">
                           <li><xsl:value-of select="@ficheiro"></xsl:value-of></li>
                       </xsl:for-each>
                    </ul>
                    
                    <xsl:value-of select="preceding-sibling::*"></xsl:value-of>
                  
                    
                    
                    <center> <a href="../indice.html" class="btn btn-primary btn-lg">Índice</a></center>
                 </body>
            </html>   
       </xsl:result-document>
        
        
    </xsl:template>
    
    
    
    
</xsl:stylesheet>