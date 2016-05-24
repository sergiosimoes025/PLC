<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="skos" version="2.0"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">


    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
        <xsl:apply-templates select="//skos:Concept[not(.=following-sibling::skos:Concept)]"
            mode="gerar-paginas"> </xsl:apply-templates>

        <html>
            <head>

                <link rel="stylesheet"
                    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css"/>
                <link rel="stylesheet"
                    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css"/>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"/>



            </head>
            <body>

                <div class="container">
                    <div class="Jumbotron">
                        <h1 class="text-center">
                            <xsl:value-of select="//skos:ConceptScheme/dc:title"/>
                        </h1>
                    </div>
                </div>
                <center>
                    <div class="text-center" style="width:600px;">
                        <h2 style="margin-bottom:30px;">
                            <mark>Top Concepts</mark>
                        </h2>
                        <ul class="list-unstyled">

                            <xsl:apply-templates
                                select="//skos:Concept[@rdf:about = ..//skos:hasTopConcept/@rdf:resource]"
                                mode="indice_top_concepts">
                                <xsl:sort select="skos:prefLabel"/>

                            </xsl:apply-templates>
                        </ul>
                    </div>

                    <div class="text-center" style="width:600px;">
                        <h2 style="margin-bottom:30px;margin-top:50px;">
                            <mark>Concepts</mark>
                        </h2>
                        <ul class="list-unstyled">

                            <xsl:apply-templates select="//skos:Concept" mode="indice_conceitos">
                                <xsl:sort select="skos:prefLabel"/>
                            </xsl:apply-templates>
                        </ul>
                    </div>
                </center>
            </body>
        </html>
    </xsl:template>


    <xsl:template match="skos:Concept" mode="gerar-paginas">
        <xsl:variable name="id">
            <xsl:value-of select="translate(@rdf:about,'#','')"/>
        </xsl:variable>
        <xsl:result-document href="concepts/{$id}.html">
            <html>
                <head>
                    <link rel="stylesheet"
                        href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css"/>
                    <link rel="stylesheet"
                        href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css"/>
                    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"/>
                </head>

                <body>
                    <center>
                        <div class="container">
                            <div class="Jumbotron">
                                <h1 class="text-center">
                                    <xsl:value-of select="skos:prefLabel"/>
                                </h1>
                            </div>
                        </div>

                        <div style="margin-top:40px; width:600px;" class="text-center">
                            <h2 class="text-center" style="margin-bottom:30px;">
                                <mark>Lexical Labels</mark>
                            </h2>


                            <ul class="list-unstyled">
                                <xsl:for-each select="skos:prefLabel|skos:altLabel">
                                    <li class="text-center text-capitalize">
                                        <strong><h4><xsl:value-of select="."/></h4></strong> -
                                                <em><xsl:value-of select="@xml:lang"/></em>
                                    </li>
                                    <hr/>
                                </xsl:for-each>
                            </ul>

                        </div>
                        



                        <div style="margin-top:40px; width:600px" class="text-center">
                            <h2 class="text-center" style="margin-bottom:30px;">
                                <mark>Semantic Relations</mark>
                            </h2>
                            <h3 class="text-center" style="margin-bottom:30px;">
                                <mark>Broaders/Narrower</mark>
                            </h3>
                            <ul class="list-unstyled">

                                <xsl:for-each select="(skos:broader/@rdf:resource | skos:narrower/@rdf:resource)">
                                    <xsl:variable name="id">
                                        <xsl:value-of select="."/>
                                    </xsl:variable>
                                    <xsl:apply-templates
                                        select="../../../skos:Concept[@rdf:about = $id ]"
                                        mode="broaders"/>
                                </xsl:for-each>
                            </ul>
                            
                        </div> 
                        <div style="margin-top:70px; width:600px" class="text-center">
                            <h3 class="text-center" style="margin-bottom:30px;">
                                <mark>Related to</mark>
                            </h3>
                            <ul class="list-unstyled">
                                
                                <xsl:for-each select="skos:related/@rdf:resource">
                                    <xsl:variable name="id">
                                        <xsl:value-of select="."/>
                                    </xsl:variable>
                                    <xsl:apply-templates
                                        select="../../../skos:Concept[@rdf:about = $id ]"
                                        mode="related"/>
                                </xsl:for-each>
                            </ul>                    
        
                        </div>

                    </center>
                    <footer style="margin-top:40px;" class="text-center">
                        <h3>
                            <a href="../indice.html">Indice</a>
                        </h3>
                    </footer>
                </body>
            </html>


        </xsl:result-document>



    </xsl:template>


    <xsl:template match="skos:Concept" mode="broaders">
        
        <li class="text-center text-capitalize"><a href="{translate(@rdf:about,'#','')}.html">
            <strong><h4><xsl:value-of select="skos:prefLabel"/></h4></strong> -
            <em><xsl:value-of select="skos:prefLabel/@xml:lang"/></em></a>
        </li>
        <hr/>
     </xsl:template>
    
    <xsl:template match="skos:Concept" mode="related">
        
        <li class="text-center text-capitalize"><a href="{translate(@rdf:about,'#','')}.html">
            <strong><h4><xsl:value-of select="skos:prefLabel"/></h4></strong> -
            <em><xsl:value-of select="skos:prefLabel/@xml:lang"/></em></a>
        </li>
        <hr/>
    </xsl:template>

    <xsl:template match="skos:Concept" mode="indice_top_concepts">

        <xsl:variable name="id">
            <xsl:value-of select="@rdf:about"/>
        </xsl:variable>
        <li>
            <h4>
                <a href="concepts/{translate($id,'#','')}.html">
                    <xsl:value-of select="skos:prefLabel"/>
                </a>
            </h4>
        </li>
        <hr/>

    </xsl:template>


    <xsl:template match="skos:Concept" mode="indice_conceitos">

        <xsl:variable name="id">
            <xsl:value-of select="@rdf:about"/>
        </xsl:variable>
        <li>
            <h4>
                <a href="concepts/{translate($id,'#','')}.html">
                    <xsl:value-of select="skos:prefLabel"/>
                </a>
            </h4>
        </li>
        <hr/>

    </xsl:template>

</xsl:stylesheet>
