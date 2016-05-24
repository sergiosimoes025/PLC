<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="html" indent="yes"/>
        <xsl:template match="/">
           <html>
           <head>
               <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
                   
                   <!-- Optional theme -->
                   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"/>
                       
                       <!-- Latest compiled and minified JavaScript -->
                       <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
           </head>
               
           <body>
               <xsl:apply-templates select="//obra[@id='m2']"></xsl:apply-templates>
           </body>    
           
           </html>
            
        </xsl:template>
        
        
        
   <xsl:template match="//obra[@id='m2']">
       Código:<xsl:value-of select="@id"/>
       <hr/>
       
       Título: <xsl:value-of select="titulo"></xsl:value-of>
       <br/>
       Compositor :<xsl:value-of select="compositor"></xsl:value-of>
       <br/>
       <p>Partitura disponíveis: </p>
       <ul>
           <xsl:for-each select="instrumentos/instrumento">
               <li><xsl:value-of select="designacao"></xsl:value-of>:<xsl:value-of select="partitura[@type]"></xsl:value-of></li>
           </xsl:for-each>
           
       </ul>    
       
       <xsl:call-template name="nav-bar"/>
   </xsl:template>
    
    
    <xsl:template name="nav-bar">
       <xsl:choose>
           <xsl:when test="preceding-sibling::obra">
               <a href="{preceding-sibling::obra[1]/@id}.html"> Anterior</a>
           </xsl:when>
           
       </xsl:choose>
        
        <a href="indice.html">Indice</a>
        
        <xsl:choose>
            <xsl:when test="following-sibling::obra">
                <a href="{following-sibling::obra[1]/@id}"> Próximo</a>
            </xsl:when>
        </xsl:choose>
        
    </xsl:template>
    
</xsl:stylesheet>