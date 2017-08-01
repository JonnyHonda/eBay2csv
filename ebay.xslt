<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <head>
        <style type="text/css">.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
.tg .tg-yw4l{vertical-align:top}</style>
      </head>
      <body>
        <h2>Ebay Items</h2>
        <table class="tg">
          <xsl:for-each select="findItemsAdvancedResponse/searchResult/item">
            <tr>
              <td class="tg-yw4l">
                <a>
                  <xsl:attribute name="href">
                    <xsl:value-of select="viewItemURL"/>
                  </xsl:attribute>
                  <img target="_blank">
                    <xsl:attribute name="src">
                      <xsl:value-of select="galleryURL"/>
                    </xsl:attribute>
                  </img>
                </a>
              </td>
              <td class="tg-yw4l">
                <a target="_blank">
                  <xsl:attribute name="href">
                    <xsl:value-of select="viewItemURL"/>
                  </xsl:attribute>
                  <xsl:value-of select="itemId"/>
                  <br/>
                </a>
                <xsl:value-of select="title"/>
                <br/>
                <b>Seller:</b>
                <xsl:value-of select="sellerInfo/sellerUserName"/>
                <br/>
                <b>Price:</b>
                £<xsl:value-of select="sellingStatus/currentPrice"/>
                <br/>
                <b>Distance:</b>
                <xsl:value-of select="distance"/>miles.
                <br/>
                <b>Payment Method:</b>
                <xsl:value-of select="paymentMethod"/>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>