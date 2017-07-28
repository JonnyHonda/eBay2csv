# eBay2csv
A bash script that converts an ebay search to a CSV file

For no other reason than to try, I wanted a file that can seach eBay and download the XML and tranlate it to CSV.

You will need eBay developer account and an App key of your own, see https://developer.ebay.com/

Put your app key in the config file and away you go.

usage:
eBay2csv.sh filename.csv "Some Sarch Terms"

eg:
./eBay2csv.sh superdream.csv "superdream, CB250N, CN400N"


Limitations:
This script creates a lot of temporary files as its going along, these will be called temp1.csv .. tempN.csv so if you call the script using:

./eBay2csv temp.csv "superdream, CB250N, CN400N" it will delete your csv when it's finished cleaning up.

The config entries
buyerPostalCode  The location used to sort by Distance Nearest

GlobalId=EBAY-GB  The eBay marketplace you wish to search
entriesPerPage=100  The number of items to return in each page, this is used by the script to split up large results, 100 is the max, making it smaller won't really help

Valid values to use are BestMatch, CurrentPriceHighest, DistanceNearest, EndTimeSoonest, PricePlusShippingHighest, PricePlusShippingLowest
DistanceNearest requiries that a buyerPostalCode is set

sortOrder=BestMatch

This was written for the Mac shell so may need tweaking for linux and windows
