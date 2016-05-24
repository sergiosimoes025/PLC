<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Oferta de Emprego</title>
            </head>
            <body>
                <xsl:apply-templates/>
                <hr/>
                <address>treste</address>
            </body>  
        </html>
        
    </xsl:template>   
    <xsl:template match="profissão"> 
        <center>
            <h1><xsl:value-of select="."/></h1>
        </center>
    </xsl:template>
   
    <xsl:template match="corpo">
        <h3>Descrição: </h3>
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="morada | idade">
        <i>
            <xsl:value-of select="."/>
        </i>
    </xsl:template>
    
    <xsl:template match="contactos">
        <hr/>
        <h3>Contactos: </h3>
        <ul>
            <xsl:apply-templates/> <!-- vai para dentro dos contactos email webpage telefone -->
        </ul>
    </xsl:template>
    
    <xsl:template match="contactos/*">
        <li>
            <xsl:value-of select="."/>
        </li>    
    </xsl:template>
    
    <xsl:template match="disponibilidade">
        <h3><b>Disponibilidade: </b></h3>
        <xsl:value-of select="."/> <!-- value of vai buscar o que ta la dentro -->
    </xsl:template>
</xsl:stylesheet>