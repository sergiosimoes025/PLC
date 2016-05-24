<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:key name="provincia" match="doc" use="prov"/>

        <xsl:template match="/*">
            <html>
                <head>
                    <title>Arquivo Sonoro de Ernesto Veiga de Oliveira</title>
                </head>
                <body>
                    <h1><center style="font-family:Arial;font-style:italic">Arquivo Sonoro de Ernesto Veiga de Oliveira</center></h1>
                    <table border="1">
                        <tr>
                            <td width="30%" valign="top">
                                <h2 style="font-family:Arial;font-style=italic;">Índice</h2>
                                <xsl:apply-templates mode="indice" select="doc[generate-id() = generate-id(key('provincia', prov))]">
                                    <xsl:sort select="prov"/>
                                </xsl:apply-templates>
                            </td>
                            <td>
                                <ul> 
                                    
                                    <xsl:apply-templates select="doc"/>
                                </ul>
                            </td>
                        </tr>
                        
                    </table>
                </body>
            </html>
           
        </xsl:template>
        
    <xsl:template match="doc">
        <a name="{generate-id()}"/>
        <h4 style="color:green;">Canção : <i><xsl:number/></i></h4>
        <br/>
        <b>Província:</b><xsl:value-of select="prov"/>
        <br/>
        <xsl:if test="local">
        <b>Local:</b> <xsl:value-of select="local"/>
            <br/>
        </xsl:if>
        <b>Título:</b> <xsl:value-of select="tit"/>
        <br/>
        
        <xsl:if test="musico">
        <b>Músico:</b> <xsl:value-of select="musico"/>
        <br/>
        </xsl:if>   
        <b>Ficheiro:</b><xsl:value-of select="file"/>
        <br/>
        <b>Duração:</b><xsl:value-of select="duracao"/>
        <br/>
        <xsl:if test="obs/file[@t='SWA']">
            <b>Obs. file(SWA):</b><xsl:value-of select="obs/file[@t='SWA']"/>
            <br/>
        </xsl:if>
        <xsl:if test="obs/file[@t='MP3']">
            <b>Obs. file(MP3):</b> <xsl:apply-templates select="obs/file[@t='MP3']"/>
            <br/>
        </xsl:if>
        <xsl:if test="obs/intxt">
            <b>Obs. intxt:</b> <xsl:apply-templates select="obs/intxt"/>
        </xsl:if>
        <hr style="border-width: 3px;"/>
    </xsl:template>
        
        <xsl:template mode="indice" match="doc">
            <hr/>
            <h3 style="font-family:Arial;"><center><xsl:value-of select="prov"/></center></h3>
            <hr/>
                    <xsl:for-each select="key('provincia', prov)">
                        <a href="#{generate-id()}">   
                            <xsl:value-of select="tit"/>
                        </a>
                        <xsl:if test="position() != last()">
                            <br/>
                        </xsl:if>
                    </xsl:for-each>
                    <br/>
                    <br/>
            <hr/>
        </xsl:template>
    
    
</xsl:stylesheet>   