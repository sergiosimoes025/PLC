<?php
    $xml = new DOMDocument;
    $xml->load('../xml/relatorio.xml');

    $xslt = new XSLTProcessor();

    $xsl = new DOMDocument();
    $xsl->load('../xsl/relatorio.xsl', LIBXML_NOCDATA);
    $xslt->importStylesheet( $xsl );
        
    print $xslt->transformToXML($xml);
?>