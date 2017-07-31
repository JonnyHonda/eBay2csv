#eBay2csv config file
ebayAppKey=
buyerPostalCode=""

GlobalId=EBAY-GB
entriesPerPage=100
# Valid values to use are BestMatch, CurrentPriceHighest, DistanceNearest, EndTimeSoonest, PricePlusShippingHighest, PricePlusShippingLowest
# DistanceNearest requiries that a buyerPostalCode is set
sortOrder=BestMatch

# the template to use as output
xslTemplate=ebay-csv.xsl
