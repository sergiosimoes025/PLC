<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">
    <xsl:output method="html" indent="yes"/>
    <!--<xsl:template match="grupo">
        <li>
            <xsl:value-of select="count(preceding-sibling::*)+1"/>;<xsl:number/>
        </li>
    
    </xsl:template>-->
    <xsl:template match="/">
        <html>
            <head>
                <title>TPS</title>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>  
        </html>   
    </xsl:template>
    
    <xsl:template match="trabalhos">
       <table border="1">
           <xsl:apply-templates/>
       </table>
    </xsl:template>
    <xsl:template match="grupo">
        <tr>
            <td>
                Grupo <xsl:number/>
            </td>
            <td>
                <table>
                <xsl:apply-templates select="aluno1|aluno2|aluno3"/>
                </table>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="aluno1|aluno2|aluno3">
        <tr>
            <td>
                <xsl:value-of select="."/> 
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>