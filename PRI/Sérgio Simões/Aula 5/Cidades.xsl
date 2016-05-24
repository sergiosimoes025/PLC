<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    <xsl:output method="html" indent="yes"/>
    
    <xsl:key name="cidades" match="cidade" use="@id"/>
    
    <xsl:template match="/">
        <xsl:result-document href="cidades/index.html">
            <html>
                <head>
                    <title>Mapa Virtual</title>
                </head>
                <body>
                    <h1>Mapa Virtual</h1>
                    <hr width="80%"/>
                    <tr>
                        <ul>
                        <xsl:apply-templates select="//cidade">
                            <xsl:sort select="nome"/>
                        </xsl:apply-templates>
                        </ul>
                    </tr> 
                </body>
            </html>
            <xsl:apply-templates select="//cidade" mode="cidade"/>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="cidade">

            <li>
            <a href="{@id}.html">
                <xsl:value-of select="nome"/>
            </a>
            </li>
        
    </xsl:template>
    
    <xsl:template match="cidade" mode="cidade">
        <xsl:result-document href="cidades/{@id}.html">
            <h2>
                <xsl:value-of select="nome"/>
                (<xsl:value-of select="@id"/>)
            </h2>
            <table>
                <tr>
                    <td>
                        Descrição
                    </td>
                    <td>
                        <xsl:value-of select="descricao"/>
                    </td>
                    <td>
                        População
                    </td>
                    <td>
                        <xsl:value-of select="populacao"/>
                    </td>
                    <td>
                        Distrito
                    </td>
                    <td>
                        <xsl:value-of select="distrito"/>
                    </td>
                </tr>
            </table>
            <h3>Ligações</h3>
            <ul>
                <xsl:variable name="c" select="@id"/>
                <xsl:apply-templates select="//ligacao[($c=origem/@cidade)]" mode="origem"/>
                <xsl:apply-templates select="//ligacao[($c=destino/@cidade)]" mode="destino"/>
            </ul>
            <hr/>
            <address>
                <a href="index.html">Voltar ao índice</a>
            </address>
        </xsl:result-document>
        
    </xsl:template>
    
    <xsl:template match="ligacao" mode="destino">
        <li>
            <a href="{origem/@cidade}.html">
                <xsl:value-of select="key('cidades',origem/@cidade)/nome"/>
            </a>
            (<xsl:value-of select="distancia"/>)
        </li>
    </xsl:template>
    
    <xsl:template match="ligacao" mode="origem">
        <li>
            <a href="{destino/@cidade}.html">
                <xsl:value-of select="key('cidades',destino/@cidade)/nome"/>
            </a>
            (<xsl:value-of select="distancia"/>)
        </li>
    </xsl:template>
</xsl:stylesheet>