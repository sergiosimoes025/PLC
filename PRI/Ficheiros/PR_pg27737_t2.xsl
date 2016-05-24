<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">
    
    <xsl:output method="html" indent="yes"/> 
    <xsl:template match="/">
        <html>
            <head>
                <title> Project Record</title>
            </head>
            <body>
                <center><h1>Project Record</h1></center>
                <hr/>
                <table width="100%">
                    <tr>
                        <td width="50%">
                            <b>KEY-NAME: </b>
                            <xsl:value-of select="project-record/meta/key-name"/> <br/>
                            
                            <b>TITLE: </b>
                            <xsl:value-of select="project-record/meta/title"/> <br/>
                            
                            <b>SUBTITLE: </b>
                            <xsl:value-of select="project-record/meta/subtitle"/> <br/>
                        </td>
                        <td width="50%">
                            <b>BEGIN-DATE: </b>
                            <xsl:value-of select="project-record/meta/begin-date"/> <br/>
                            <b>END-DATE: </b>
                            <xsl:value-of select="project-record/meta/end-date"/> <br/>
                            <b>SUPERVISORS: </b>
                            <xsl:text></xsl:text>
                            <xsl:apply-templates select="project-record/meta/supervisors"/>
                            <br/>
                        </td>
                    </tr>
                </table>

                <hr/>
                <hr/>
                <h2>ABSTRACT: </h2>
                <xsl:apply-templates select="project-record/abstract"/>
            </body>
        </html>
        </xsl:template>
        
        <xsl:template match="abstract">
            <h3>Abstract</h3>
            <xsl:apply-templates/>
        </xsl:template>
        
        <xsl:template match="p">
            <p>
                <xsl:apply-templates/>            
            </p>
        </xsl:template>
    
        <xsl:template match="b">
            <b>
                <xsl:apply-templates/>
            </b>
        </xsl:template>
    
    <xsl:template match="i">
        <i>
            <xsl:apply-templates/>
        </i>
    </xsl:template>
    
    <xsl:template match="supervisors">
        <ul>
            <xsl:apply-templates/>      
        </ul>
    </xsl:template>
    
    <xsl:template match="supervisor">
        <li>
            <a href="{homepage}">
                <xsl:value-of select="name"/>
            </a>,
            <xsl:value-of select="email"/>
        </li>
    </xsl:template>
</xsl:stylesheet>