<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">
    <xsl:output method="html" indent="yes"/>
    <!--<xsl:template match="grupo">
        <li>
            <xsl:value-of select="count(preceding-sibling::*)+1"/>;<xsl:number/>
        </li>
    
    </xsl:template>-->
    <xsl:template match="/">
        <html>
            <head>
                <title>TPS</title>
                
                    
                    
              
            </head>
            <body>
                
                <center><h1 style="font-size:30px">Listagem dos Trabalhos Práticos de PLI (por grupo)</h1></center>
                <xsl:apply-templates/>
            </body>  
        </html>   
    </xsl:template>
    
    <xsl:template match="trabalhos">
        
       <table border="1">
           <tr>
           <th>Grupo</th>
           <th>Constituição</th>
           <th>Título</th>
           <th>Ficheiro</th>
           <th>Data de Envio</th>
           </tr>
           <xsl:apply-templates/>
       </table>
    </xsl:template>
    
    
    <xsl:template match="grupo">
      
        <tr>
            <td>
                Grupo <xsl:number/>
            </td>
            <td>
                <center>
                    <table border="0" cellpadding="10">
                       <tr>
                           <th style="color:green;font-family:arial;font-style: italic">Numero</th>
                           <th style="color:red;font-family:arial;font-style: italic">Nome </th>
                           <th style="color:blue;font-family:arial;font-style: italic">Curso</th>
                         </tr>
                       <xsl:apply-templates select="aluno1|aluno2|aluno3"/>
                    </table>
                </center>
                
            </td>
            <td>
                <xsl:value-of select="titulo"/>
               </td>
            <td>
                <a href="{file}">
                <xsl:value-of select="file"/>
                </a>  
            </td>
            
            <td>
                
                <xsl:value-of select="data"/>
            </td>
            
            
        </tr>
    
    </xsl:template>
    
    <xsl:template match="aluno1|aluno2|aluno3">
        <tr>
            <td>
                <xsl:value-of select="numero1"/>
                <xsl:value-of select="numero2"/>
                <xsl:value-of select="numero3"/>
            </td>
            
            <td>
                <xsl:value-of select="nome1"/>
                <xsl:value-of select="nome2"/>
                <xsl:value-of select="nome3"/>
            </td>
            
            <td>
                <xsl:value-of select="curso1"/>
                <xsl:value-of select="curso2"/>
                <xsl:value-of select="curso3"/>
            </td>   
        </tr>
        
    </xsl:template>
  </xsl:stylesheet>