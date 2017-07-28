#!/bin/bash
args=("$@")
# Fetch in the config file
if [ -f ./eBay2csv.cfg ]; then
    . ./eBay2csv.cfg
else
    echo "Can't find eBay2csv.cfg file does it exist?"
    exit
fi

if [ $# = 2 ]; then 
    searchTerms=$2
    echo "Search terms: $searchTerms"
    # Replace white spaces, this should really be an html entities replace really
    searchTerms="${searchTerms// /%20}"
    if [ "$sortOrder" == "DistanceNearest" ]; then
        if [ -z "$buyerPostalCode" ]; then
            echo "Sorting by Distance Nearest requires buyerPostalCode to be set in the config"
            exit
        fi
    fi
    buyerPostalCode="${buyerPostalCode// /%20}"
    echo "Fetching initial information from eBay..."
    curl -s "http://svcs.ebay.com/services/search/FindingService/v1?OPERATION-NAME=findItemsAdvanced&SERVICE-VERSION=1.0.0&GLOBAL-ID=$GlobalId&SECURITY-APPNAME=$ebayAppKey&keywords=$searchTerms&itemFilter(0).name=ListingType&itemFilter(0).value=FixedPrice&paginationInput.entriesPerPage=$entriesPerPage&paginationInput.pageNumber=1&sortOrder=$sortOrder&RESPONSE-DATA-FORMAT=XML$locationString" > temp1.xml;
    sed -i.bak 's/xmlns="http:\/\/www.ebay.com\/marketplace\/search\/v1\/services"//g' temp1.xml;
    totalPages=`xmllint --xpath '/findItemsAdvancedResponse/paginationOutput/totalPages/text()' temp1.xml`
    totalEntries=`xmllint --xpath '/findItemsAdvancedResponse/paginationOutput/totalEntries/text()' temp1.xml`
    if [ $totalEntries = 0 ]; then
        echo "No results found"
        exit
    fi
    echo "Total number of items found $totalEntries in $totalPages pages"
    echo "Remove old csv file..."
    
    # Remove old file if present
    if [ -f $1 ]; then
        rm $1
    fi

    echo "Creating new CSV file..."
    cat header.csv > $1
    echo "Fetching data from eBay..." 
    for i in $(seq 1 $totalPages); 
	    do curl -s "http://svcs.ebay.com/services/search/FindingService/v1?OPERATION-NAME=findItemsAdvanced&SERVICE-VERSION=1.0.0&GLOBAL-ID=$GlobalId&SECURITY-APPNAME=$ebayAppKey&keywords=$searchTerms&itemFilter(0).name=ListingType&itemFilter(0).value=FixedPrice&paginationInput.entriesPerPage=$entriesPerPage&paginationInput.pageNumber=$i&sortOrder=$sortOrder&RESPONSE-DATA-FORMAT=XML&buyerPostalCode=$buyerPostalCode" > temp$i.xml;
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

