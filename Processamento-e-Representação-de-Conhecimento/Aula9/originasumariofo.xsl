<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://ww.oxygenxml.com/ns/doc/xsl"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="xs xd"
    version="2.0">
    
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b>May 4,2015</xd:p>
            <xd:p><xd:b>Author:</xd:b>Eu</xd:p>
            <xd:p>Gerador de PDF para os sumarios</xd:p>
        </xd:desc>
        
    </xd:doc>
    

    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="primeira" page-width="210mm" page-height="297mm">
                    <fo:region-body region-name="PageBody" margin="1.5cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="primeira">
                <fo:flow flow-name="PageBody">
                    <fo:block text-align="center" space-after="1cm">
                        <fo:block font-size="24pt">SUMÁRIOS</fo:block>
                        <fo:block>
                            <xsl:apply-templates select="sumarios/disciplina"/>
                        </fo:block>
                    </fo:block>
                    <fo:block space-before="2cm">
                        <xsl:apply-templates select="sumarios/aulas/aula"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    <xsl:template match="disciplina">
        <fo:block font-size="20pt">
            <xsl:value-of select="curso"/>
        </fo:block>
        <fo:block font-size="18pt">
            <xsl:value-of select="designacao"/>
        </fo:block>
    </xsl:template>
    <xsl:template match="aula">
        <fo:block font-size="12pt" space-after="1cm">
            <fo:block color="blue">
                <xsl:value-of select="data"/>
            </fo:block>
            <fo:block color="grey">
                <xsl:value-of select="tema"/>
            </fo:block>
            <fo:block>
                <xsl:apply-templates select="sumario"/>
            </fo:block>
        </fo:block>
    </xsl:template>
    <xsl:template match="sumario">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="p">
        <fo:block space-after="3pt">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
   

</xsl:stylesheet>
