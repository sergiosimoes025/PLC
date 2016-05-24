<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd"
    version="1.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p>
                <xd:b>Created on:</xd:b> 28 Fev de  2015</xd:p>
            <xd:p>
                <xd:b>Author:</xd:b> Sérgio Simões</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:output method="html" indent="yes"/>    
    
    <xsl:template match="/">
        <html>
            <head>
                
                <style>
                    #titulo{
                        font-variant:small-caps;
                        font-size:40px;
                        text-align:center;
                        color:red;
                        border:1px solid black;
                        background-color:#F0F8FF;
                    }
                    
                    
                </style>
                <!-- Latest compiled and minified CSS -->
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>

                <!-- Optional theme --> 
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"/>

                <!-- Latest compiled and minified JavaScript -->
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
                <title>Project record</title>
            </head>
            <body>
                <center>
                    <h1 style="color:red;font-size:60px;border:1px solid black;margin-bottom:40px;background-color: #F0F8FF;">Project record</h1>
                </center>
               
                <table width="100%" border="1">
                    <tr>
                        <td width="50%">
                            <b>KEY-NAME: </b> 
                            <xsl:value-of select="project-record/meta/key-name"/> 
                            <br/>
                            
                            <b>TITLE: </b> 
                            <xsl:value-of select="project-record/meta/title"/> 
                            <br/>
                            
                            <b>SUBTITLE:  </b> 
                            <xsl:value-of select="project-record/meta/subtitle"/> 
                            <br/>
                        </td>
                        <td width="50%">
                            <b>BEGIN-DATE: </b> 
                            <xsl:value-of select="project-record/meta/begin-date"/> 
                            <br/>
                            
                            <b>END-DATE: </b> 
                            <xsl:value-of select="project-record/meta/end-date"/> 
                            <br/>
                            
                            <b>SUPERVISORS:</b> 
                            <xsl:apply-templates select="project-record/meta/supervisors"/> 
                            <br/>
                        </td>
                    </tr>
                </table>
                
                
                <br/>
                <xsl:apply-templates select="project-record/workteam"/>
               
                <hr/>
                <xsl:apply-templates select="project-record/abstract"/>
                
                <hr/>
                <xsl:apply-templates select="project-record/deliverables"/>
                
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="abstract">
        <h2 id="titulo" style="text-align:center;">Abstract</h2>
        
        
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="workteam">
        <h2 id="titulo" style="text-align:center;">WorkTeam </h2>
        
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="student">
      <div style="margin-left:30px;"> 
            <i style = "color:green;">Id : </i> 
            <xsl:value-of select="ident"/>
        </div> 
        <div style="margin-left:30px;"> 
            <i style = "color:red;">Name :  </i> 
            <xsl:value-of select="name"/>
        </div> 
        <div style="margin-left:30px;"> 
            <i style = "color:blue;">Email :  </i> 
            <a href="mailto:{email}">
                <xsl:value-of select="email"/>
            </a>
        </div> 
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
    
    <xsl:template match="ul">
        <xsl:for-each select="li">
            
            <li style="margin-left:10px">
                <xsl:value-of select="."/>
            </li>
            
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="deliverables">
        <h2 id="titulo"> Deliverables :</h2>
        
        <xsl:for-each select="xref">
            <li style = "margin-left:20px;">
                <a href = "{@url}">
                    <xsl:value-of select="current()"/>
                </a>
            </li>
        </xsl:for-each> 
        <hr/>
        
        
        <img  src="http://png-4.findicons.com/files/icons/2315/default_icon/34/copyright.png"></img>
        <i>Copyright Sérgio Simões - Março 2015</i>
    </xsl:template>
    
    
    
    
    
</xsl:stylesheet>