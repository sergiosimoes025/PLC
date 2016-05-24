<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:key name="autores" match="author" use="@id"/>
    <xsl:key name="editores" match="editor" use="@id"/>
    
    <xsl:template match="/">
        <xsl:result-document href="out/index.html">
            <html>
                <head>
                    <title>Publicação do JCR</title>
                </head>
                <body>
                    <h1 align="center">Publicação do JCR</h1>
                    <hr width="80%"/>
                    <table width="100%">
                        <tr>
                            <td width="30%" valign="top">
                                <!-- Geração do indice -->
                                
                                <xsl:apply-templates mode="indice" select="//author|//editor">
                                    <xsl:sort />
                                </xsl:apply-templates>
                            </td>
                            <td width="70%" valign="top">
                                <ul>
                                    <xsl:apply-templates select="//bibliography/*">
                                        <xsl:sort select="year" order="descending"/>
                                        <xsl:sort select="month" order="descending"/>
                                    </xsl:apply-templates>
                                    
                                </ul>
                            </td>
                        </tr>
                    </table>
                    
                </body>
            </html>
        </xsl:result-document>
        
        
    </xsl:template>
    
    <xsl:template match="author|editor" mode ="indice">
        <h4>
            <xsl:value-of select="."/>
        </h4>
        <xsl:variable name="n" select="@id"/>
        <ol>
            <xsl:for-each select="//bibliography/*[($n=author/@id)or($n=author-ref/@authorid)or($n=editor/@id)or($n=editor-ref/@authorid)]">
                <li>
                    <a href="{@id}.html">
                    <xsl:value-of select="@id"/>
                    </a>
                </li>
            </xsl:for-each>
        </ol>
    </xsl:template>
    
    <xsl:template match="//bibliography/*">
        <xsl:result-document href="out/{@id}.html">
        <li>
            [<xsl:value-of select="@id"/>]
            <b>
                <xsl:value-of select="title"/>
            </b>,
            <i>
                <xsl:apply-templates/>
            </i>            
        </li>
            <h6>
                <adress>
                    <a href="index.html">Voltar ao índice</a>
                </adress>
            </h6>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="author|editor">
        <xsl:value-of select="."/>,
    </xsl:template>
    
    <xsl:template match="author-ref|editor-ref">
        <xsl:value-of select="key('autores',@authorid)"/>,
    </xsl:template>
    
    <xsl:template match="text()" priority="-1"/>
    
</xsl:stylesheet>