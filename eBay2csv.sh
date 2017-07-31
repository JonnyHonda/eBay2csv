#!/bin/bash
args=("$@")
# Fetch in the config file
if [ -f ./eBay2csv.cfg ]; then
    . ./eBay2csv.cfg
else
    echo "Can't find eBay2csv.cfg file does it exist?"
    exit
fi

# Checking that the xslt file is available
if [ ! -f "$xslTemplate" ]; then
    echo "Can't find the required xsl template file $xslTemplate"
    exit
fi

if [ $# = 2 ]; then 
    searchTerms=$2
    locationString=""
    echo "Search terms: $searchTerms"
    # Replace white spaces, this should really be an html entities replace really
    searchTerms="${searchTerms// /%20}"
    if [ "$sortOrder" == "DistanceNearest" ]; then
        if [ -z "$buyerPostalCode" ]; then
            echo "Sorting by Distance Nearest requires buyerPostalCode to be set in the config"
            exit
        else
            buyerPostalCode="${buyerPostalCode// /%20}"
            locationString="&buyerPostalCode=$buyerPostalCode"
        fi
    fi
    
    # Replace the spaces in the PostalCode with html entity %20
    buyerPostalCode="${buyerPostalCode// /%20}"
    
    # Download the fist page and extract some data from it.
    echo "Fetching initial information from eBay..."
    curl -s "http://svcs.ebay.com/services/search/FindingService/v1?OPERATION-NAME=findItemsAdvanced&SERVICE-VERSION=1.0.0&GLOBAL-ID=$GlobalId&SECURITY-APPNAME=$ebayAppKey&keywords=$searchTerms&itemFilter(0).name=ListingType&itemFilter(0).value=FixedPrice&paginationInput.entriesPerPage=$entriesPerPage&paginationInput.pageNumber=1&sortOrder=$sortOrder&RESPONSE-DATA-FORMAT=XML$locationString" > temp1.xml;
 
    # Had some problems with XML name spacing, the quickest workaround for me was to remove the xmlns definition 
    sed -i.bak 's/xmlns="http:\/\/www.ebay.com\/marketplace\/search\/v1\/services"//g' temp1.xml;

    # Extract the number of pages in the result set
    totalPages=`xmllint --xpath '/findItemsAdvancedResponse/paginationOutput/totalPages/text()' temp1.xml`
    
    # Extract the total number of entries return by the search
    totalEntries=`xmllint --xpath '/findItemsAdvancedResponse/paginationOutput/totalEntries/text()' temp1.xml`
    if [ $totalEntries = 0 ]; then
        echo "No results found"
        exit
    fi
    echo "Total number of items found $totalEntries in $totalPages pages"
    
    # Remove old file if present
    if [ -f $1 ]; then
        echo "Remove old csv file..."
        rm $1
    fi

    # Create the new CSV file
    echo "Creating new CSV file..."
    cat header.csv > $1

    echo "Fetching data from eBay..." 
    for i in $(seq 1 $totalPages); 
	    do curl -s "http://svcs.ebay.com/services/search/FindingService/v1?OPERATION-NAME=findItemsAdvanced&SERVICE-VERSION=1.0.0&GLOBAL-ID=$GlobalId&SECURITY-APPNAME=$ebayAppKey&keywords=$searchTerms&itemFilter(0).name=ListingType&itemFilter(0).value=FixedPrice&outputSelector=SellerInfo&paginationInput.entriesPerPage=$entriesPerPage&paginationInput.pageNumber=$i&sortOrder=$sortOrder&RESPONSE-DATA-FORMAT=XML$locationString" > temp$i.xml;
	    echo "Fetching data from page $i"
	    
        # Had some problems with XML name spacing, the quickest workaround for me was to remove the xmlns definition
        sed -i.bak 's/xmlns="http:\/\/www.ebay.com\/marketplace\/search\/v1\/services"//g' temp$i.xml;

        # Trying to remove random double quotes in the xml, for example someone may put 18" for 18 inch, this is breaking the csv output
	    sed -i.bak 's/&quot;//g' temp$i.xml;

        # Do the translation
        xsltproc -o temp$i.csv $xslTemplate temp$i.xml

        # Appent the csv page data to the csv file
	    cat temp$i.csv >> $1
    done

    # Clean up the temp files created by the script
    echo "Cleaning up..."
    rm *.xml
    rm *.bak
    rm temp*.csv
else
    # print out some basic usage intructions
	echo "usage:"
	echo "get-listings.sh filename.csv \"Some Search Terms\""
fi

