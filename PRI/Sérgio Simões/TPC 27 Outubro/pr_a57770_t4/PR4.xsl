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
                <title>Project Record</title>
            </head>
            <body>
                <center><h1>Project Record</h1></center>
                <hr/>
                <table width="100%">
                    <tr>
                        <td width="50%">
                            <b>KEY-NAME: </b>
                            <xsl:text></xsl:text>
                            <xsl:value-of select="project-record/meta/Keyname"/> <br/>
                            
                            <b>TITLE: </b>
                            <xsl:text></xsl:text>
                            <xsl:value-of select="project-record/meta/Title"/> <br/>
                            
                            <b>SUBTITLE: </b>
                            <xsl:text></xsl:text>
                            <xsl:value-of select="project-record/meta/Subtitle"/> <br/>
                        </td>
                        <td width="50%">
                            <b>BEGIN DATE: </b>
                            <xsl:text></xsl:text>
                            <xsl:value-of select="project-record/meta/BeginDate"/> <br/>
                            
                            <b>END DATE: </b>
                            <xsl:text></xsl:text>
                            <xsl:value-of select="project-record/meta/EndDate"/> <br/>
                            
                            <b>SUPERVISOR: </b>
                            <xsl:text></xsl:text>
                            <xsl:apply-templates select="project-record/meta/Supervisor"/> <br/>
                        </td>
                    </tr>
                </table>
                <hr/>
                <hr/>
                
                <xsl:apply-templates select="project-record/WorkTeam"></xsl:apply-templates>
                <hr/>
                <hr/>
                <xsl:apply-templates select="project-record/Abstract"></xsl:apply-templates>
                <hr/>
                <hr/>
                <xsl:apply-templates select="project-record/Deliverables"></xsl:apply-templates>
                
            </body>
        </html> 
        
    </xsl:template>
    <xsl:template match="Abstract">
        <h3>Abstract</h3>
        <xsl:apply-templates/>
        
    </xsl:template>
    
    <xsl:template match="WorkTeam">
        <h3>WorkTeam</h3>
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
    
    <xsl:template match="Supervisor">
        <ul>
            <xsl:apply-templates/>
            
        </ul>
    </xsl:template>
    <xsl:template match="student">
       <tr> 
           <td><b>Número:</b>
            <xsl:value-of select="ident"/>
               </td>
               <td>
                   <b>Nome:</b>
             <xsl:value-of select="name"/>
               </td>
               <td><b>Email:</b>
                   <xsl:value-of select="email"/>
                   </td>
       </tr>
        
        
    </xsl:template>
    <xsl:template match="Deliverables">
        <h3>Deliverables</h3>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="xref">
        <ul><li>
            <a href="{@url}">
                <xsl:value-of select="."/>
            </a>
        </li>
            
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