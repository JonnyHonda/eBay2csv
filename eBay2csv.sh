#!/bin/bash
args=("$@")
# Fetch in the config file
. ./eBay2csv.cfg

if [ $# = 2 ]; then 
    searchTerms=$2
    echo "Search terms: $searchTerms"
    # Replace white spaces, this should really be an html entities replace really
    searchTerms="${searchTerms// /%20}"
    echo "Fetching initial information from eBay..."
    curl -s "http://svcs.ebay.com/services/search/FindingService/v1?OPERATION-NAME=findItemsAdvanced&SERVICE-VERSION=1.0.0&GLOBAL-ID=EBAY-GB&SECURITY-APPNAME=$ebayAppKey&keywords=$searchTerms&itemFilter(0).name=ListingType&itemFilter(0).value=FixedPrice&paginationInput.entriesPerPage=100&paginationInput.pageNumber=1&sortOrder=BestMatch&RESPONSE-DATA-FORMAT=XML" > temp1.xml;
    sed -i.bak 's/xmlns="http:\/\/www.ebay.com\/marketplace\/search\/v1\/services"//g' temp1.xml;
    totalPages=`xmllint --xpath '/findItemsAdvancedResponse/paginationOutput/totalPages/text()' temp1.xml`
    totalEntries=`xmllint --xpath '/findItemsAdvancedResponse/paginationOutput/totalEntries/text()' temp1.xml`
    if [ $totalEntries = 0 ]; then
        echo "No results found"
        exit
    fi
    echo "Total number of items found $totalEntries in $totalPages pages"
    echo "Remove old csv file..."
    rm $1
    echo "Creating new CSV file..."
    cat header.csv > $1
    echo "Fetching data from eBay..." 
    for i in $(seq 1 $totalPages); 
	    do curl -s "http://svcs.ebay.com/services/search/FindingService/v1?OPERATION-NAME=findItemsAdvanced&SERVICE-VERSION=1.0.0&GLOBAL-ID=EBAY-GB&SECURITY-APPNAME=$ebayAppKey&keywords=$searchTerms&itemFilter(0).name=ListingType&itemFilter(0).value=FixedPrice&paginationInput.entriesPerPage=100&paginationInput.pageNumber=$i&sortOrder=BestMatch&RESPONSE-DATA-FORMAT=XML" > temp$i.xml;
	    echo "Fetching data from page $i"
	    sed -i.bak 's/xmlns="http:\/\/www.ebay.com\/marketplace\/search\/v1\/services"//g' temp$i.xml;
	    xsltproc -o temp$i.csv ebay-csv.xslt temp$i.xml
	    cat temp$i.csv >> $1
    done

    echo "Cleaning up..."
    rm *.xml
    rm *.bak
    rm temp*.csv
else
	echo "usage:"
	echo "get-listings.sh filename.csv \"Some Search Terms\""
fi

