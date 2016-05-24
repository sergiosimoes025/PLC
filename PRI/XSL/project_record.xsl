<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd"
    version="1.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Oct 6, 2014</xd:p>
            <xd:p><xd:b>Author:</xd:b> jcr</xd:p>
            <xd:p>Exercíco da aula3 de PRI2014</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:output method="html" indent="yes"/>    
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Project record</title>
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
                            
                            <b>SUPERVISORS:</b> 
                            <xsl:apply-templates select="project-record/meta/supervisors"/> 
                            <br/>
                        </td>
                    </tr>
                </table>
                
                <hr/>
                <hr/>
                <xsl:apply-templates select="project-record/workteam"/>
                <hr/>
                <hr/>
                <xsl:apply-templates select="project-record/abstract"/>
                <hr/>
                <hr/>
                <xsl:apply-templates select="project-record/deliverables"/>
                
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="abstract">
        <h2>Abstract</h2>
        
        
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="workteam">
        <h2>WorkTeam : </h2>
        
        <xsl:apply-templates/>
            </xsl:template>
    
    <xsl:template match="student">
        <hr/>
        <div> <i style = "color:green;">Id : </i> <xsl:value-of select="ident"/></div> 
        <div> <i style = "color:red;">Name :  </i> <xsl:value-of select="name"/></div> 
        <div> <i style = "color:blue;">Email :  </i> <a href="mailto:{email}"><xsl:value-of select="email"/></a></div> 
        <p/>
       
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
    
    <xsl:template match="deliverables">
        <h2> Deliverables :</h2>
        
        <xsl:for-each select="xref">
        <li style = "margin-left:20px;">
            <a href = "{@url}"><xsl:value-of select="current()"/></a>
        </li>
        </xsl:for-each> 
        <hr/>
        
        
        <img  src="http://png-4.findicons.com/files/icons/2315/default_icon/34/copyright.png"></img>
        <i>Copyright Sérgio Simões - Outubro 2014</i>
        </xsl:template>
    
   
    
       
    
</xsl:stylesheet>