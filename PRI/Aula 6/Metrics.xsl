<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="/">
        <html>  
            <head>
                <title>XML Document Metrics</title>
            </head>
            
            <body>
                <center><h1>XML Document Metrics</h1></center>
                <table width="100%" border="1">
                <tr>
                      <th>Name</th><th align="right">N</th>
                      <th>Fan-in</th><th>Fan-out</th>
                      <th align="right">Level</th>
                    <th align="right">Descendants</th>
                </tr>
                  <xsl:for-each select="//*[not(name(.)=preceding::*/name())]">
                      <xsl:sort select="name(.)"/>
                      <xsl:variable name="n" select="name(.)"/>
                      <tr>
                          <td>
                              <xsl:value-of select="name(.)"/>
                          </td>
                          <td align="right">
                              
                              <xsl:value-of select="count(//*[name(.)=$n])"/>
                          </td>
                          <td>
                              <ul>
                                  <xsl:for-each-group select="//*[name(.)=$n]" group-by="parent::*/name()">
                                   <li>
                                       <xsl:value-of select="parent::*/name()"/>
                                   </li>   
                                  </xsl:for-each-group>
                              </ul>
                          </td>
                          <td>
                              <ul>
                                  <xsl:for-each-group select="//*[name(.)=$n]/*" group-by="name()">
                                      <li>
                                          <xsl:value-of select="name()"/>
                                      </li>   
                                  </xsl:for-each-group>
                              </ul>
                          </td>
                          <td>
                              <ul>
                                  <xsl:for-each-group select="//*[name(.)=$n]" group-by="count(ancestor-or-self::*)">
                                      
                                      <li>
                                          <xsl:value-of select="count(ancestor-or-self::*)"/>
                                      </li>
                                  
                                  </xsl:for-each-group>
                                  
                              </ul>
                             
                          </td>
                          <td>
                              <ul>
                                  <xsl:for-each-group select="//*[name(.)=$n]" group-by="count(descendant::*)">
                                      
                                      <li>
                                          <xsl:value-of select="count(descendant::*)"/>
                                      </li>
                                      
                                  </xsl:for-each-group>
                                  
                              </ul>
                              
                          </td>
                      </tr>
                      
                  </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="address">
        <tr>
            <td>
            <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
    
</xsl:stylesheet>