<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://ww.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd"
    version="1.0">
    
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b> Created on:</xd:b></xd:p>
            <xd:p><xd:b> Author:</xd:b> Perez</xd:p>
            
        </xd:desc>
    </xd:doc>    
    
    <xsl:output method = "html" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head><title>Anuncios</title>
                <meta http-equiv="refresh" content="1"></meta>
                <style>
                    body {background-color:lightgray}
                    h1   {color:blue}
                    p    {color:green}
                    titulo { font-size:30px;
                             font-family:Arials;
                             font-style:italic;
                             margin:auto;  
                    }
                </style>
            </head>
            <body>
                <center><titulo>Anuncios</titulo></center>
                <xsl:text></xsl:text>
                <xsl:apply-templates select="project-record/meta/supervisors"/><br/>
                
            </body>
        </html>
        
        
    </xsl:template>
    <xsl:template match="anuncios">
        <ul>
            <xsl:apply-templates/>
        </ul>
        
    </xsl:template>
    
    
    <xsl:template match="anuncio">
        <xsl:for-each select="anuncios/anuncio">
            <tr>
                <td><xsl:value-of select="profissao"/></td>
                
            </tr>
        </xsl:for-each>
        
    </xsl:template>
</xsl:stylesheet>