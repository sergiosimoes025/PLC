<xsl:stylesheet  version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:ex="http://www.di.uminho.pt/jcr/XML/rdf/ex2#">
    

    <xsl:template match="/">
        <rdf:RDF>
            
            <rdf:Description rdf:ID="Publicacao">
                <rdf:type rdf:resource="http://www.w3.org/2000/01/rdf-schema#Class"/>
            </rdf:Description>
            
            <rdf:Description rdf:ID="Proceedings">
                <rdf:type rdf:resource="http://www.w3.org/2000/01/rdf-schema#Class"/>
                <rdfs:subClassOf rdf:resource="#Publicacao"/>
            </rdf:Description>
            
            <rdf:Description rdf:ID="InProceedings">
                <rdf:type rdf:resource="http://www.w3.org/2000/01/rdf-schema#Class"/>
                <rdfs:subClassOf rdf:resource="#Publicacao"/>
            </rdf:Description>
            
            <rdf:Description rdf:ID="Article">
                <rdf:type rdf:resource="http://www.w3.org/2000/01/rdf-schema#Class"/>
                <rdfs:subClassOf rdf:resource="#Publicacao"/>
            </rdf:Description>
            
            <rdf:Description rdf:ID="Misc">
                <rdf:type rdf:resource="http://www.w3.org/2000/01/rdf-schema#Class"/>
                <rdfs:subClassOf rdf:resource="#Publicacao"/>
            </rdf:Description>
            
            <rdf:Description rdf:ID="PhdThesis">
                <rdf:type rdf:resource="http://www.w3.org/2000/01/rdf-schema#Class"/>
                <rdfs:subClassOf rdf:resource="#Publicacao"/>
            </rdf:Description>
            
            <rdf:Description rdf:ID="MasterThesis">
                <rdf:type rdf:resource="http://www.w3.org/2000/01/rdf-schema#Class"/>
                <rdfs:subClassOf rdf:resource="#Publicacao"/>
            </rdf:Description>
            
            
            <rdf:Description rdf:ID="Inbook">
                <rdf:type rdf:resource="http://www.w3.org/2000/01/rdf-schema#Class"/>
                <rdfs:subClassOf rdf:resource="#Publicacao"/>
            </rdf:Description>
            
            <rdf:Description rdf:ID="Book">
                <rdf:type rdf:resource="http://www.w3.org/2000/01/rdf-schema#Class"/>
                <rdfs:subClassOf rdf:resource="#Publicacao"/>
            </rdf:Description>
            
            <rdf:Description rdf:ID="Pessoa">
                <rdf:type rdf:resource="http://www.w3.org/2000/01/rdf-schema#Class"/>
            </rdf:Description>
            
            <rdf:Description rdf:ID="Autor">
                <rdf:type rdf:resource="http://www.w3.org/2000/01/rdf-schema#Class"/>
                <rdfs:subClassOf rdf:resource="#Pessoa"/>
            </rdf:Description>
            
            <rdf:Description rdf:ID="Editor">
                <rdf:type rdf:resource="http://www.w3.org/2000/01/rdf-schema#Class"/>
                <rdfs:subClassOf rdf:resource="#Pessoa"/>
            </rdf:Description>
            
           
            
            
            <!-- ..........Propriedades..........................-->
            
            <rdfs:Datatype rdf:about="http://www.w3.org/2001/XMLSchema#string"/>
            
            <rdf:Property rdf:ID="nome">
                <rdfs:domain rdf:resource="#Pessoa"/>
                <rdfs:range rdf:resource="http://www.w3.org/2001/XMLSchema#string"/>
            </rdf:Property>
            
            <rdf:Property rdf:ID="temAutor">
                <rdfs:domain rdf:resource="#Publicacao"/>
                <rdfs:range rdf:resource="#Pessoa"/>
            </rdf:Property>
            
            
            <rdf:Property rdf:ID="temDeliverables">
                <rdfs:domain rdf:resource="#Publicacao"/>
            </rdf:Property>
            
            
            <rdf:Property rdf:ID="temEditor">
                <rdfs:domain rdf:resource="#Publicacao"/>
                <rdfs:range rdf:resource="#Pessoa"/>
            </rdf:Property>
            
            <rdf:Property rdf:ID="data">
                <rdfs:domain rdf:resource="#Publicacao"/>
            </rdf:Property>
            
            <rdf:Property rdf:ID="titulo">
                <rdfs:domain rdf:resource="#Publicacao"/>
            </rdf:Property>
            
            <rdf:Property rdf:ID="doi">
                <rdfs:domain rdf:resource="#Publicacao"/>
            </rdf:Property>
            
            <rdf:Property rdf:ID="publisher">
                <rdfs:domain rdf:resource="#Inbook"/>
                <rdfs:domain rdf:resource="#Article"/>
                <rdfs:domain rdf:resource="#Book"/>
            </rdf:Property>
            
            <rdf:Property rdf:ID="booktitle">
                <rdfs:domain rdf:resource="#Inproceedings"/>
            </rdf:Property>
            
            <rdf:Property rdf:ID="address">
                <rdfs:domain rdf:resource="#Inproceedings"/>
                <rdfs:domain rdf:resource="#Book"/>
            </rdf:Property>
            
            <rdf:Property rdf:ID="isbn">
                <rdfs:domain rdf:resource="#Inproceedings"/>
                <rdfs:domain rdf:resource="#Proceedings"/>
            </rdf:Property>
            
            
            <rdf:Property rdf:ID="issn">
                <rdfs:domain rdf:resource="#Article"/>
            </rdf:Property>
            
            
            <rdf:Property rdf:ID="journal">
                <rdfs:domain rdf:resource="#Article"/>
            </rdf:Property>
            
            <rdf:Property rdf:ID="number">
                <rdfs:domain rdf:resource="#Article"/>
            </rdf:Property>
            
            <rdf:Property rdf:ID="volume">
                <rdfs:domain rdf:resource="#Article"/>
            </rdf:Property>
            
            <rdf:Property rdf:ID="school">
                <rdfs:domain rdf:resource="#Phdthesis"/>
                <rdfs:domain rdf:resource="#Masterthesis"/>
            </rdf:Property>
            
            
            <rdf:Property rdf:ID="howpublished">
                <rdfs:domain rdf:resource="#Misc"/>
            </rdf:Property>
            
           
            
            <!-- OCORRENCIAS -->
            <xsl:apply-templates select="//author[not(.=following::autor)]"/>
            <xsl:apply-templates select="//editor[not(.=following::editor)]"/>
            <xsl:apply-templates select="//inbook"/>
            <xsl:apply-templates select="//inproceedings"/>
            <xsl:apply-templates select="//article"/>
            <xsl:apply-templates select="//misc"/> 
            <xsl:apply-templates select="//book"/>
            <xsl:apply-templates select="//phdthesis"/>
            <xsl:apply-templates select="//masterthesis"/>
            
        </rdf:RDF>
    </xsl:template>
    
    <xsl:template match="misc">
        <xsl:element name="ex:Misc">
            <xsl:attribute name="rdf:ID"><xsl:value-of select="@id"/></xsl:attribute>
            <xsl:element name="ex:temAutor">
                <xsl:element name="rdf:Bag">
                    <xsl:for-each select="author-ref">
                        <xsl:element name="rdf:li">
                            <xsl:attribute name="resources"><xsl:value-of select="@authorid"/></xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>    
            </xsl:element>
            <xsl:element name="ex:titulo"><xsl:value-of select="title"/></xsl:element>
            <xsl:element name="ex:Doi"><xsl:value-of select="doi"/></xsl:element>
            <xsl:element name="date"><xsl:value-of select="year"/></xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="inbook">
     <xsl:element name="ex:Inbook">
        <xsl:attribute name="rdf:ID"><xsl:value-of select="@id"/></xsl:attribute>
        <xsl:element name="ex:titulo"><xsl:value-of select="title"/></xsl:element>
        <xsl:element name="ex:temAutor">
            <xsl:element name="rdf:Bag">
                <xsl:for-each select="author-ref">
                    <xsl:element name="rdf:li">
                        <xsl:attribute name="resources"><xsl:value-of select="@authorid"/></xsl:attribute>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>    
        </xsl:element>
        <xsl:element name="ex:Publisher"><xsl:value-of select="publisher"/></xsl:element>
        <xsl:element name="ex:Doi"><xsl:value-of select="doi"/></xsl:element>
     </xsl:element>
    </xsl:template>
    
    <xsl:template match="author">
        <xsl:element name="ex:Autor">
            <xsl:attribute name="rdf:ID"><xsl:value-of select="@id"/></xsl:attribute>
            <xsl:element name="ex:nome"><xsl:value-of select="."/></xsl:element>
        </xsl:element>
        
    </xsl:template>
    
    <xsl:template match="editor">
        <xsl:element name="ex:Editor">
            <xsl:attribute name="rdf:ID"><xsl:value-of select="@id"/></xsl:attribute>
            <xsl:element name="ex:nome"><xsl:value-of select="."/></xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="inproceedings">
        <xsl:element name="ex:InProceedings">
            <xsl:attribute name="rdf:id"><xsl:value-of select="@id"/></xsl:attribute>
            <xsl:element name="ex:titulo"><xsl:value-of select="title"/></xsl:element>
            <xsl:element name="ex:temAutor">
                <xsl:element name="rdf:Bag">
                    <xsl:for-each select="author-ref">
                        <xsl:element name="rdf:li">
                            <xsl:attribute name="resources"><xsl:value-of select="@authorid"/></xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                    <xsl:for-each select="author">
                        <xsl:element name="rdf:li">
                            <xsl:attribute name="resources"><xsl:value-of select="@id"/></xsl:attribute>
                        </xsl:element>
                        
                    </xsl:for-each>
                    
                </xsl:element>    
            </xsl:element>
            <xsl:element name="ex:data"><xsl:value-of select="year"/></xsl:element>
            <xsl:element name="ex:address"><xsl:value-of select="address"/></xsl:element>
            <xsl:element name="ex:isbn"><xsl:value-of select="isbn"/></xsl:element>
            <xsl:element name="ex:booktitle"><xsl:value-of select="booktitle"/></xsl:element>
            <xsl:element name="ex:doi"><xsl:value-of select="doi"/></xsl:element>
        </xsl:element>
    </xsl:template>
        
        
        
        <xsl:template match="article">
            <xsl:element name="ex:Article">
                <xsl:attribute name="rdf:id"><xsl:value-of select="@id"/></xsl:attribute>
                <xsl:element name="ex:titulo"><xsl:value-of select="title"/></xsl:element>
                <xsl:element name="ex:temAutor">
                    <xsl:element name="rdf:Bag">
                        <xsl:for-each select="author-ref">
                            <xsl:element name="rdf:li">
                                <xsl:attribute name="resources"><xsl:value-of select="@authorid"/></xsl:attribute>
                            </xsl:element>
                        </xsl:for-each>
                        <xsl:for-each select="author">
                            <xsl:element name="rdf:li">
                                <xsl:attribute name="resources"><xsl:value-of select="@id"/></xsl:attribute>
                            </xsl:element>
                        </xsl:for-each>
                    </xsl:element>    
                </xsl:element>
                <xsl:element name="ex:journal"><xsl:value-of select="journal"/></xsl:element>
                <xsl:element name="ex:issn"><xsl:value-of select="issn"/></xsl:element>
                <xsl:element name="ex:volume"><xsl:value-of select="volume"/></xsl:element>
                <xsl:element name="ex:number"><xsl:value-of select="number"/></xsl:element>
                <xsl:element name="ex:data"><xsl:value-of select="year"/></xsl:element>
                <xsl:element name="ex:doi"><xsl:value-of select="doi"/></xsl:element>
                <xsl:element name="ex:temDeliverables">
                    <xsl:element name="rdf:Bag">
                        <xsl:for-each select="deliverables/*">
                            <xsl:element name="rdf:li"><xsl:attribute name="resources"><xsl:value-of select="@url"/></xsl:attribute></xsl:element>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:template>
    
    
    <xsl:template match="book">
        <xsl:element name="ex:Book">
            <xsl:attribute name="rdf:id"><xsl:value-of select="@id"/></xsl:attribute>
            <xsl:element name="ex:titulo"><xsl:value-of select="title"/></xsl:element>
            <xsl:element name="ex:temAutor">
                <xsl:element name="rdf:Bag">
                    <xsl:for-each select="author-ref">
                        <xsl:element name="rdf:li">
                            <xsl:attribute name="resources"><xsl:value-of select="@authorid"/></xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                    <xsl:for-each select="author">
                        <xsl:element name="rdf:li">
                            <xsl:attribute name="resources"><xsl:value-of select="@id"/></xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>    
            </xsl:element>
            <xsl:element name="ex:Publisher"><xsl:value-of select="publisher"/></xsl:element>
            <xsl:element name="ex:date"><xsl:value-of select="year"/>-<xsl:value-of select="month"/></xsl:element>
            <xsl:element name="ex:Address"><xsl:value-of select="address"/></xsl:element>
            <xsl:element name="ex:temDeliverables">
                <xsl:element name="rdf:Bag">
                    <xsl:for-each select="deliverables/*">
                        <xsl:element name="rdf:li"><xsl:attribute name="resources"><xsl:value-of select="@url"/></xsl:attribute></xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:element>
            <xsl:element name="ex:Doi"><xsl:value-of select="doi"/></xsl:element>
        </xsl:element>
    </xsl:template>
        
    
    <xsl:template match="phdthesis">
        <xsl:element name="ex:Phdthesis">
            <xsl:attribute name="rdf:id"><xsl:value-of select="@id"/></xsl:attribute>
            <xsl:element name="ex:temAutor">
                <xsl:element name="rdf:Bag">
                    <xsl:for-each select="author-ref">
                        <xsl:element name="rdf:li">
                            <xsl:attribute name="resources"><xsl:value-of select="@authorid"/></xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                    <xsl:for-each select="author">
                        <xsl:element name="rdf:li">
                            <xsl:attribute name="resources"><xsl:value-of select="@id"/></xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>    
            </xsl:element>
            <xsl:element name="ex:titulo"><xsl:value-of select="title"/></xsl:element>
            <xsl:element name="ex:school"><xsl:value-of select="school"/></xsl:element>
            <xsl:element name="ex:date"><xsl:value-of select="year"/>-<xsl:value-of select="month"/></xsl:element>
            <xsl:element name="ex:address"><xsl:value-of select="address"/></xsl:element>
            <xsl:element name="ex:temDeliverables">
                <xsl:element name="rdf:Bag">
                    <xsl:for-each select="deliverables/*">
                        <xsl:element name="rdf:li"><xsl:attribute name="resources"><xsl:value-of select="@url"/></xsl:attribute></xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="masterthesis">
        <xsl:element name="ex:Phdthesis">
            <xsl:attribute name="rdf:id"><xsl:value-of select="@id"/></xsl:attribute>
            <xsl:element name="ex:temAutor">
                <xsl:element name="rdf:Bag">
                    <xsl:for-each select="author-ref">
                        <xsl:element name="rdf:li">
                            <xsl:attribute name="resources"><xsl:value-of select="@authorid"/></xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                    <xsl:for-each select="author">
                        <xsl:element name="rdf:li">
                            <xsl:attribute name="resources"><xsl:value-of select="@id"/></xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>    
            </xsl:element>
            <xsl:element name="ex:titulo"><xsl:value-of select="title"/></xsl:element>
            <xsl:element name="ex:school"><xsl:value-of select="school"/></xsl:element>
            <xsl:element name="ex:date"><xsl:value-of select="year"/>-<xsl:value-of select="month"/></xsl:element>
            <xsl:element name="ex:address"><xsl:value-of select="address"/></xsl:element>
            <xsl:element name="ex:temDeliverables">
                <xsl:element name="rdf:Bag">
                    <xsl:for-each select="deliverables/*">
                        <xsl:element name="rdf:li"><xsl:attribute name="resources"><xsl:value-of select="@url"/></xsl:attribute></xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>