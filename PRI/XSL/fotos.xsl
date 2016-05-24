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
            
            <title>fotos</title>
            </head>
        <body style="background-color:#ECE5E5;">
            
            <center><h1 style="font-size:30px;color:#00ff00;background-color:grey;font-family:Arial">Fotos</h1></center>
            <xsl:apply-templates/>
        </body>  
    </html>   
</xsl:template>

<xsl:template match="fotos">
    <table  style="width:100%;" border="1">
        <tr>
            <th style="color:blue;font-family:Arial;font-style:italic">Ficheiro</th>
            <th style="color:blue;font-family:Arial;font-style:italic">Data </th>
            <th style="color:blue;font-family:Arial;font-style:italic">Quem</th>
            <th style="color:blue;font-family:Arial;font-style:italic">Legenda</th>
            <th style="color:blue;font-family:Arial;font-style:italic">Local</th>
        </tr>
        <xsl:apply-templates/>
    </table>
    <div style="background-color:#FFF;margin-top:100px;text-align:center;font-family:Arial;font-size:20px;">Voltar ao indice</div> 
</xsl:template>


<xsl:template match="foto">
   <tr>
       <td><a href="{@ficheiro}"><xsl:value-of select="@ficheiro"/></a></td>
       <td><xsl:value-of select="quando/@data"/></td>
       <td><xsl:value-of select="quem"/></td>
       <td><xsl:value-of select="facto"/></td>
       <td><xsl:value-of select="onde"/></td>
   </tr>
    
  
</xsl:template>
    
</xsl:stylesheet>