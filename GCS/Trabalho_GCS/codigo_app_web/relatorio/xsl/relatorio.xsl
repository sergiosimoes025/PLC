<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:r="http://elpri.di.uminho.pt/report"
    xmlns:p="http://elpri.di.uminho.pt/paragraph"
    xmlns:l="http://elpri.di.uminho.pt/list"
    exclude-result-prefixes="xs xd"
    version="1.0">
    
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
                <meta name="viewport" content="width=device-width, initial-scale=1.0" /> 

                <link rel="stylesheet" type="text/css" href="../../css/default.css" />
                <link rel="stylesheet" type="text/css" href="../../css/component.css" />
                <link rel="stylesheet" type="text/css" href="../../css/bootstrap.min.css" />
                <link rel="stylesheet" type="text/css" href="../../css/font-awesome.min.css" />

                <title>Base de Dados de Emigração: Relatório</title>
            </head>

            <body class="cbp-spmenu-push" style="font-family: 'Lato', Calibri, Arial, sans-serif;"> 

              <nav class="cbp-spmenu cbp-spmenu-horizontal cbp-spmenu-bottom" id="cbp-spmenu-s4">
                <h3>Créditos</h3>
                <p style="border-left:0px;">Fernando Martins - PG25297</p>
                <p>Hélder Rocha - PG27737</p>
                <p>Sérgio Simões - A64283</p>
                <p>Tiago Martins - PG25306</p>
              </nav>

              <div class="container">
                <header class="clearfix">
                  <span style="display:block;">Processamento e Representação de Informação</span>
                  <h1>Base dados de Emigração</h1>
                  <div class="masthead">
                    <nav>
                      <ul class="nav nav-justified" style="margin-top:20px;">
                        <li><a href="../../index.php">Início</a></li>
                        <li class="dropdown">
                          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Arquivo Fotográfico<span class="caret"></span></a>
                          <ul class="dropdown-menu" role="menu">
                            <li class="dropdown-header">Registos</li>
                            <li><a href="../../arquivo_fotografico/html/adicionar_registos_fotograficos.html">Adicionar</a></li>
                            <li><a href="../../arquivo_fotografico/php/reset_registos_fotograficos.php">Remover</a></li>
                          </ul>
                        </li>
                        <li class="dropdown">
                          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Arquivo Biográfico<span class="caret"></span></a>
                          <ul class="dropdown-menu" role="menu">
                            <li class="dropdown-header">Registos</li>
                            <li><a href="../../arquivo_biografico/html/adicionar_registos_biograficos.html">Adicionar</a></li>
                            <li><a href="../../arquivo_biografico/php/reset_registos_biograficos.php">Remover</a></li>
                          </ul>
                        </li>
 	    		              <li><a href="../../arquivo_requerimento_passaportes/html/adicionar_registos_passaporte.html">A.R.P.</a></li>
                        <li class="active"><a href="#">Relatório</a></li>
                        <li><a id="showBottom" href="#">Créditos</a></li>
                      </ul>
                    </nav>
                  </div>
                </header>

                  <div class="main">
                    <div class="row">
                        <div class="col-md-3 sidebar-offcanvas" id="sidebar" role="navigation">
                          <h2>Conteúdo</h2>
                          <div data-spy="affix" data-offset-top="45" data-offset-bottom="90">
                            <ul class="nav" id="sidebar-nav">
                              <li><a href="#abstract">Resumo</a></li>
                              <xsl:apply-templates select="//r:section" mode="indice" />
                            </ul>
                          </div>
                        </div>
                        <div class="col-md-9" data-spy="scroll" data-target="#sidebar-nav">
                          <xsl:apply-templates/>
                        </div>
                    </div>
                  </div>
              </div>
  
              <script src="../../js/jquery-2.1.3.min.js"></script>
              <script src="../../js/bootstrap.min.js"></script>
              <script src="../../js/modernizr.custom.js"></script>
              <script src="../../js/classie.js"></script>
              <script src="../../js/custom.js"></script>
            </body>
        </html> 
    </xsl:template>
    
    <xsl:template mode="indice" match="r:section">
        <li><a href="#{@id}"><xsl:value-of select="r:title" /></a></li>
    </xsl:template>

    <xsl:template match="r:meta">
        <h2><xsl:value-of select="r:title"/> <small>[<xsl:value-of select="r:date"/>]</small></h2>
        <h3><xsl:value-of select="r:subttitle"/></h3>
        <xsl:apply-templates mode="nomes" select="r:authors"/>        
    </xsl:template>
    
    <xsl:template mode="nomes" match="r:authors">
      <div class="row">
        <xsl:for-each select="r:author">
          <div class="col-sm-4 col-md-3">
            <div class="thumbnail">
                <img src="{r:photo/@path}" alt="foto" style="width:171px;height:180px;" />
                <div class="caption">
                  <h4>Nome</h4>
                  <p><xsl:value-of select="r:name"/></p>
                  <h4>Número</h4>
                  <p><xsl:value-of select="r:identifier"/></p>
                  <!--
                  <h4>E-mail</h4>
                  <p><xsl:value-of select="r:email" /></p>
                  -->
                </div>
            </div>
          </div>
        </xsl:for-each>
       </div>
    </xsl:template>
    
    <xsl:template match="r:abstract">
        <h2 id="abstract">Resumo</h2>
        <xsl:value-of select="."></xsl:value-of>
    </xsl:template>
    
    
    <xsl:template match="r:section">
        <hr/>
       <h2  style = " font-size: 24px; color: #fff; padding: 4px;  background: #696;" id="{@id}"><xsl:value-of select="r:title"/></h2>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="//p:p[not(descendant::*)]">
        <p><xsl:value-of select="."/></p>
    </xsl:template>
    
    <xsl:template match="//p:p[(descendant::*)]">
       <xsl:for-each select="p:b">
           <b><xsl:value-of select="."/></b>
       </xsl:for-each>
        
        <xsl:for-each select="p:xref">
            <li><p><a href="{@href}"><xsl:value-of select="."/></a></p></li>
        </xsl:for-each>
        
        
        
    </xsl:template>
  
  <xsl:template match="//l:ul">
      <ul>
        <xsl:for-each select="l:li">
            <li>
             <xsl:value-of select="."/>                    
            </li>
        </xsl:for-each>  
      </ul>
  </xsl:template>
    
    <xsl:template match="r:section/r:photo">
        <img src="{@path}" />
        <p><xsl:value-of select="."/></p>
    </xsl:template>
    
    <xsl:template match="r:subsection">
        <h3 id="{@id}"><xsl:value-of select="r:title"/></h3>
        <xsl:apply-templates/>
    </xsl:template>
    
    
    
    <xsl:template match="r:subsection/r:photo">
       <img src="{@path}" />
        <p><xsl:value-of select="."/></p>
    </xsl:template>


    <xsl:template match="r:subsubsection">
       
        <h4 id="{@id}"><xsl:value-of select="r:title"/></h4>
        <xsl:apply-templates/>
    </xsl:template>

    
    <xsl:template match="r:subsubsection/r:photo">
        <img src="{@path}" />
        <p><xsl:value-of select="."/></p>
    </xsl:template>

    <xsl:template match="r:bibitem">
        <b><xsl:value-of select="r:title"/></b>-<xsl:value-of select="r:date"/><xsl:apply-templates mode="bibliografia" select="r:authors"/>
    </xsl:template>
    
    <xsl:template mode="bibliografia" match="r:authors">
            <xsl:for-each select="r:author">
                , <xsl:value-of select="."/>
            </xsl:for-each>.
    </xsl:template>
    
    <xsl:template match="r:appendix">
        <xsl:value-of select="r:title"/>
        <xsl:value-of select="p:p"></xsl:value-of>
    </xsl:template>
    
    <xsl:template match="text()" priority="-1"/>
    
</xsl:stylesheet>