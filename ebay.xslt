<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   <xsl:output method="text/html" encoding="UTF-8"/>
<xsl:template match="/findItemsAdvancedResponse/">
<html> 
<body>
  <h2>eBay Superdream Parts</h2>
  <table border="1">
    <tr bgcolor="#9acd32">
<th style="text-align:left">itemId</th>
      <th style="text-align:left">title</th>
      <th style="text-align:left">globalId</th>
      <th style="text-align:left">primaryCategory/categoryId</th>
      <th style="text-align:left">primaryCategory/categoryName</th>
      <th style="text-align:left">galleryURL</th>
      <th style="text-align:left">viewItemURL</th>
      <th style="text-align:left">paymentMethod</th>
      <th style="text-align:left">autoPay</th>
      <th style="text-align:left">postalCode</th>
      <th style="text-align:left">location</th>
      <th style="text-align:left">country</th>
      <th style="text-align:left">shippingInfo/shippingServiceCost</th>
      <th style="text-align:left">shippingInfo/shippingType</th>
      <th style="text-align:left">shippingInfo/shipToLocations</th>
      <th style="text-align:left">sellingStatus/currentPrice</th>
      <th style="text-align:left">sellingStatus/convertedCurrentPrice</th>
      <th style="text-align:left">sellingStatus/sellingState</th>
      <th style="text-align:left">sellingStatus/timeLeft</th>
      <th style="text-align:left">listingInfo/bestOfferEnabled</th>
      <th style="text-align:left">listingInfo/buyItNowAvailable</th>
      <th style="text-align:left">listingInfo/startTime</th>
      <th style="text-align:left">listingInfo/endTime</th>
      <th style="text-align:left">listingInfo/listingType</th>
      <th style="text-align:left">listingInfo/gift</th>
      <th style="text-align:left">condition/conditionId</th>
      <th style="text-align:left">condition/conditionDisplayName</th>
      <th style="text-align:left">isMultiVariationListing</th>
      <th style="text-align:left">topRatedListing</th>
    </tr>
    <xsl:for-each select="searchResult/item">
    <tr>
      <td><xsl:value-of select="itemId" /></td>
      <td><xsl:value-of select="title" /></td>
      <td><xsl:value-of select="globalId" /></td>
      <td><xsl:value-of select="primaryCategory/categoryId" /></td>
      <td><xsl:value-of select="primaryCategory/categoryName" /></td>
      <td><xsl:value-of select="galleryURL" /></td>
      <td><xsl:value-of select="viewItemURL" /></td>
      <td><xsl:value-of select="paymentMethod" /></td>
      <td><xsl:value-of select="autoPay" /></td>
      <td><xsl:value-of select="postalCode" /></td>
      <td><xsl:value-of select="location" /></td>
      <td><xsl:value-of select="country" /></td>
      <td><xsl:value-of select="shippingInfo/shippingServiceCost" /></td>
      <td><xsl:value-of select="shippingInfo/shippingType" /></td>
      <td><xsl:value-of select="shippingInfo/shipToLocations" /></td>
      <td><xsl:value-of select="sellingStatus/currentPrice" /></td>
      <td><xsl:value-of select="sellingStatus/convertedCurrentPrice" /></td>
      <td><xsl:value-of select="sellingStatus/sellingState" /></td>
      <td><xsl:value-of select="sellingStatus/timeLeft" /></td>
      <td><xsl:value-of select="listingInfo/bestOfferEnabled" /></td>
      <td><xsl:value-of select="listingInfo/buyItNowAvailable" /></td>
      <td><xsl:value-of select="listingInfo/startTime" /></td>
      <td><xsl:value-of select="listingInfo/endTime" /></td>
      <td><xsl:value-of select="listingInfo/listingType" /></td>
      <td><xsl:value-of select="listingInfo/gift" /></td>
      <td><xsl:value-of select="condition/conditionId" /></td>
      <td><xsl:value-of select="condition/conditionDisplayName" /></td>
      <td><xsl:value-of select="isMultiVariationListing" /></td>
      <td><xsl:value-of select="topRatedListing" /></td>
    </tr>
    </xsl:for-each>
  </table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>

