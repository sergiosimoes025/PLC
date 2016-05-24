<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">
    
    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Supervisões do JCR</title>
            </head>
            <body>
                <h2>Supervisões do JCR</h2>
                <h3>Phd</h3>
                <h4>Undergoing</h4>
                <ul>
                    <xsl:apply-templates select="thesup/the[@type='phd'][@status='undergoing']"/>
                </ul>
                <h4>Concluded</h4>
                <ul>
                    <xsl:apply-templates select="thesup/the[@type='phd'][@status='concluded']"/>
                </ul>
                
                <h3>Msc</h3>
                <h4>Undergoing</h4>
                <ul>
                    <xsl:apply-templates select="thesup/the[@type='msc'][@status='undergoing']"/>
                </ul>
                <h4>Concluded</h4>
                <ul>
                    <xsl:apply-templates select="thesup/the[@type='msc'][@status='concluded']"/>
                </ul>
                
            </body>
        </html>
        
        
        
    </xsl:template>
    
    <xsl:template match="the[@status='undergoing']">
        <li>
            <b>
                <xsl:value-of select="document/title"/>
            </b>,
            <xsl:value-of select="beginyear"/>
                <i>
                    <xsl:value-of select="student/name"/>,
                </i>
            <xsl:choose>
                <xsl:when test="student/program/address">
                    <a href="{student/program/address}">
                        <xsl:value-of select="student/program/desc"/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="student/program/desc"/>
                </xsl:otherwise>
            </xsl:choose>,
            <xsl:if test="cosup">
                co-supervised by
                <xsl:value-of select="cosup/name"/>
                <xsl:value-of select="cosup/inst"/>
            </xsl:if>
            <xsl:value-of select="inst"/>
        </li>
        
    </xsl:template>
    <xsl:template match="the[@status='concluded']">
        <li>
            <b>
                <xsl:choose>
                    <xsl:when test="document/doi">
                        <a href="{document/doi}">
                            <xsl:value-of select="document/title"/>
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="document/title"/>
                        </xsl:otherwise>
                </xsl:choose>
                
            </b>,
            <xsl:value-of select="endyear"/>
            <i>
                <xsl:value-of select="student/name"/>,
            </i>
            <xsl:choose>
                <xsl:when test="student/program/address">
                    <a href="{student/program/address}">
                        <xsl:value-of select="student/program/desc"/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="student/program/desc"/>
                </xsl:otherwise>
            </xsl:choose>,
            <xsl:if test="cosup">
                co-supervised by
                <xsl:value-of select="cosup/name"/>
                <xsl:value-of select="cosup/inst"/>
            </xsl:if>
            <xsl:value-of select="inst"/>;
        </li>
        
    </xsl:template>
    
</xsl:stylesheet>