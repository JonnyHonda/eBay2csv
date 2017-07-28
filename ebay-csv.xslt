<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="1.0" xmlns="http://www.w3.org/1999/XSL/Transform">
  <output encoding="UTF-8" method="text" indent="no"/>
  <template match="/" >
    <for-each select="findItemsAdvancedResponse/searchResult/item">
      <value-of select="itemId"/>,"<value-of select="title"/>",<value-of select="globalId"/>,<value-of select="primaryCategory/categoryId"/>,"<value-of select="primaryCategory/categoryName"/>",<value-of select="galleryURL"/>,<value-of select="viewItemURL"/>,<value-of select="paymentMethod"/>,<value-of select="autoPay"/>,"<value-of select="postalCode"/>","<value-of select="location"/>","<value-of select="country"/>",<value-of select="shippingInfo/shippingServiceCost"/>,<value-of select="shippingInfo/shippingType"/>,<value-of select="shippingInfo/shipToLocations"/>,<value-of select="sellingStatus/currentPrice"/>,<value-of select="sellingStatus/convertedCurrentPrice"/>,<value-of select="sellingStatus/sellingState"/>,<value-of select="sellingStatus/timeLeft"/>,<value-of select="listingInfo/bestOfferEnabled"/>,<value-of select="listingInfo/buyItNowAvailable"/>,<value-of select="listingInfo/startTime"/>,<value-of select="listingInfo/endTime"/>,<value-of select="listingInfo/listingType"/>,<value-of select="listingInfo/gift"/>,<value-of select="condition/conditionId"/>,<value-of select="condition/conditionDisplayName"/>,<value-of select="isMultiVariationListing"/>,<value-of select="topRatedListing"/>,<value-of select="distance"/><text>&#xd;</text><text>&#xa;</text>
      </for-each>
  </template>
</stylesheet>
