<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
        <xsl:result-document href="mef.html">
            <html>
                <head>
                    <meta charset="utf-8"/>
                    <title>Indice de classes</title>
                    <link rel="stylesheet" type="text/css"
                        href="http://bootswatch.com/flatly/bootstrap.min.css"/>
                </head>
                <body style="width:95%;margin:1em auto 1em auto">
                    <h2>Indice de classes</h2>
                    <ul>
                        <xsl:apply-templates mode="indice" select="mef/classe">
                            <xsl:sort select="@codigo"/>
                        </xsl:apply-templates>
                    </ul>
                </body>
            </html>
            <xsl:apply-templates select="//classe">
                <xsl:sort select="@codigo"/>
            </xsl:apply-templates>
        </xsl:result-document>
    </xsl:template>

    <xsl:template mode="indice" match="classe">
        <li>
            <a href="site/{@codigo}.html">
                <xsl:value-of select="@codigo"/> - <xsl:value-of select="titulo"/>
            </a>
            <xsl:if test="subclasses">
                <ul>
                    <xsl:apply-templates mode="indice" select="subclasses/classe">
                        <xsl:sort select="@codigo"/>
                    </xsl:apply-templates>
                </ul>
            </xsl:if>
        </li>
    </xsl:template>
    
    <xsl:template mode="sub" match="classe">
        <li>
            <a href="{@codigo}.html">
                <xsl:value-of select="@codigo"/> - <xsl:value-of select="titulo"/>
            </a>
        </li>
    </xsl:template>

    <xsl:template match="classe">
        <xsl:result-document href="site/{@codigo}.html">
            <html>
                <head>
                    <meta charset="utf-8"/>
                    <title><xsl:value-of select="@codigo" /></title>
                    <link rel="stylesheet" type="text/css"
                        href="http://bootswatch.com/flatly/bootstrap.min.css"/>
                </head>
                <body style="width:95%;margin:1em auto 1em auto">
                    <div class="btn-group btn-group-justified">
                        <xsl:choose>
                            <xsl:when test="preceding-sibling::classe">
                                <a href="{preceding-sibling::classe[1]/@codigo}.html" class="btn btn-primary btn-lg">
                                    Anterior: <xsl:value-of select="preceding-sibling::classe[1]/@codigo" />
                                </a>
                            </xsl:when>
                            <xsl:when test="../../preceding-sibling::classe">
                                <a href="{../../preceding-sibling::classe[1]/@codigo}.html" class="btn btn-primary btn-lg">
                                    Anterior: <xsl:value-of select="../../preceding-sibling::classe[1]/@codigo" />
                                </a>
                            </xsl:when>
                            <xsl:when test="../../../../preceding-sibling::classe">
                                <a href="{../../../../preceding-sibling::classe[1]/@codigo}.html" class="btn btn-primary btn-lg">
                                    Anterior: <xsl:value-of select="../../../../preceding-sibling::classe[1]/@codigo" />
                                </a>
                            </xsl:when>
                            <xsl:otherwise>
                                <a href="#" class="btn btn-primary disabled btn-lg">
                                    Anterior: N/A
                                </a>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                        <a href="../mef.html" class="btn btn-primary btn-lg">Índice</a>
                        
                        <xsl:choose>
                            <xsl:when test="following-sibling::classe">
                                <a href="{following-sibling::classe[1]/@codigo}.html" class="btn btn-primary btn-lg">
                                    Seguinte: <xsl:value-of select="following-sibling::classe[1]/@codigo" />
                                </a>
                            </xsl:when>
                            <xsl:when test="../../following-sibling::classe">
                                <a href="{../../following-sibling::classe[1]/@codigo}.html" class="btn btn-primary btn-lg">
                                    Seguinte: <xsl:value-of select="../../following-sibling::classe[1]/@codigo" />
                                </a>
                            </xsl:when>
                            <xsl:when test="../../../../following-sibling::classe">
                                <a href="{../../../../following-sibling::classe[1]/@codigo}.html" class="btn btn-primary btn-lg">
                                    Seguinte: <xsl:value-of select="../../../../following-sibling::classe[1]/@codigo" />
                                </a>
                            </xsl:when>
                            <xsl:otherwise>
                                <a href="#" class="btn btn-primary disabled btn-lg">
                                    Seguinte: N/A
                                </a>
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>
                    
                    <h3 style="text-align:center">
                        [<xsl:value-of select="@codigo" />]
                    </h3>
                    
                    <h3 style="text-align:center;text-decoration:underline">
                        <xsl:value-of select="titulo"/>
                    </h3>

                    <h3>Descrição</h3>
                    <xsl:apply-templates select="desc"/>

                    <h3>Notas aplicacionais</h3>
                    <xsl:apply-templates select="notas-aplic"/>

                    <h3>Notas de exclusão</h3>
                    <xsl:apply-templates select="notas-excl"/>
                    
                    <h3>Subclasses directas</h3>
                    <xsl:apply-templates mode="sub" select="subclasses/classe" >
                        <xsl:sort select="@codigo"/>
                    </xsl:apply-templates>
                    
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="ul">
        <ul>
            <xsl:apply-templates select="li" />
        </ul>
    </xsl:template>
    
    <xsl:template match="li">
        <li>
            <xsl:apply-templates />
        </li>
    </xsl:template>
    
    <xsl:template match="p">
        <p>
            <xsl:apply-templates />
        </p>
    </xsl:template>
    
    <xsl:template match="iref">
        <a href="{@cref}.html">
            <xsl:value-of select="@cref" />
        </a>
    </xsl:template>

</xsl:stylesheet>
