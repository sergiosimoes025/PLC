<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://ww.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd"
    version="1.0">    
    <xsl:output method = "html" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head><title>Biografias</title>
            <link rel='stylesheet' type='text/css' href='../../css/stylesheet.css'/>
                
            </head>
            <body>
                <div id="title">Registos de biografias</div>
                <xsl:text></xsl:text>
                <div style="margin-top:40px;">
                <xsl:apply-templates select="arquivo_biografias/biografia"/><br/>
                </div>
                <center>
                    <a href="../html/arquivo_biografico.html">Voltar</a>
                </center>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="arquivo_biografias/biografia">
        <br/>
        <table border="0" align="center">
            <tr>
                <th>Data</th>
                <td><xsl:value-of select="data"/></td>
            </tr>
            <tr>
                <th>Local</th>
                <td>
                    <xsl:choose>
                      <xsl:when test="local/text()">
                        <xsl:value-of select="local"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <b>Não existe / omitido</b>
                      </xsl:otherwise>
                    </xsl:choose>
                    
                </td>
            </tr>
            <tr>
                <th>Sujeito</th>
                <td>
                    <xsl:choose>
                      <xsl:when test="sujeito/text()">
                        <xsl:value-of select="sujeito"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <b>Não existe / omitido</b>
                      </xsl:otherwise>
                    </xsl:choose>
                </td>
            </tr>
            <tr>
                <th>Evento</th>
                <td>
                    <xsl:choose>
                      <xsl:when test="evento/text()">
                        <xsl:value-of select="evento"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <b>Não existe / omitido</b>
                      </xsl:otherwise>
                    </xsl:choose>
                </td>
            </tr>
            <tr>
                <th>Nota Biográfica</th>
                <td>
                    <xsl:value-of select="nota"/>
                </td>
            </tr>
        </table>
        <br/>
        <hr/>
    </xsl:template>
    
    
</xsl:stylesheet>