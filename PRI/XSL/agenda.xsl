<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <xsl:output
        method="html"
        encoding="iso-8859-1"
        indent="yes"/>
    
    <xsl:key name="ent-ind" match="entrada" use="@id"/>
    
    <xsl:template match="agenda">
        <h1>Agenda de Contactos</h1>
        <hr/>
        <h2><a name="indice">Índice de entradas</a></h2>
        <xsl:apply-templates mode="indice"/>
        <hr/>
        <h2>Entradas</h2>
        <xsl:apply-templates/>
        <hr/>
        <h6>by jcr 2002</h6>
    </xsl:template>
    
    <xsl:template match="grupo">
        <hr/>
        <h3><a name="{@gid}">Grupo: <xsl:value-of select="@gid"/></a></h3>
        [<a href="#indice">Índice</a>]
        <ol>
            <xsl:apply-templates/> 
        </ol>
        <hr/>
    </xsl:template>
    
    <xsl:template match="entrada">
        <h3><a name="{@id}">Entrada: <xsl:value-of select="@id"/></a></h3>
        <dl>
            <dt>Nome: </dt><dd><xsl:value-of select="nome"/></dd>
            <dt>Email: </dt><dd><xsl:value-of select="email"/></dd>
            <dt>Telefone: </dt><dd><xsl:value-of select="telefone"/></dd>
        </dl>
    </xsl:template>
    
    <xsl:template match="ref">
        <h3>Entrada: <xsl:value-of select="@entref"/></h3>
        <dl>
            <dt>Nome: </dt><dd><xsl:value-of select="key('ent-ind',@entref)/nome"/></dd>
            <dt>Email: </dt><dd><xsl:value-of select="key('ent-ind',@entref)/email"/></dd>
            <dt>Telefone: </dt><dd><xsl:value-of select="key('ent-ind',@entref)/telefone"/></dd>
        </dl>
    </xsl:template>
    
    <!-- Criação do Índice -->
    
    <xsl:template match="entrada" mode="indice">
        [<a href="#{@id}"><xsl:value-of select="@id"/></a>]
    </xsl:template>
    
    <xsl:template match="grupo" mode="indice">
        [<a href="#{@gid}"><xsl:value-of select="@gid"/></a>]
    </xsl:template>
    
    
    <xsl:template match="text()" priority="-1" mode="indice"/>
    
    
</xsl:stylesheet>
