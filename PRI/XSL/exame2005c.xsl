<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="html" indent="yes"/>
    


    <xsl:template match="/">
        <html>
            <head> </head>
            <body>
                <h1> Lista de avós</h1>
                <table border="1" align="center" width="100%">
                    <tr>
                        <th> Nome </th>
                        <th> Pai </th>
                        <th> Avós </th>
                    </tr>

                    <xsl:apply-templates select="//pessoa"/>

                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="pessoa">
        <tr>
            <td>
                <xsl:value-of select="nome"/>
            </td>
            <xsl:variable name="id_pai" select="pai/@ref"/>
            <td>
               <xsl:value-of select="//pessoa[@id=$id_pai]/nome"></xsl:value-of>    
                    
            </td>
            <xsl:variable name="id_avo" select="//pessoa[@id=$id_pai]/pai/@ref"/>
            <td>
            
              <xsl:value-of select="//pessoa[@id=$id_avo]/nome"></xsl:value-of> 
            </td> 
        </tr>
    </xsl:template>


</xsl:stylesheet>
