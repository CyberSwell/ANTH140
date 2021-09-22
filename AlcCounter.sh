#!/bin/bash

# Get current date
FILE_DATE=`date +"%Y-%m-%d-%H-%M"`

# Get the webpage via CURL
WEBPAGE=$(curl -s "https://www.finewineandgoodspirits.com/webapp/wcs/stores/servlet/StoreStateSearch?storeId=10051&langId=-1&catalogId=10051&ItemCode=000004249&SearchNow=on&ProdName=Crown+Russe+Vodka+80+Proof&fromURL=%2Fwebapp%2Fwcs%2Fstores%2Fservlet%2FCatalogSearchResultView%3FstoreId%3D10051%26catalogId%3D10051%26langId%3D-1%26sType%3DSimpleSearch%26resultCatEntryType%3D2%26showResultsPage%3Dtrue%26pageSize%3D15%26sortBy%3D5%26searchSource%3DQ%26pageView%3D%26beginIndex%3D0%26searchTerm%3DCrown%26SearchKeyWord%3DCrown&countyName=Centre&f=&storeName=&pageNum=&perPage=&storeType=&city=&zip_code=&county=14&storeNO=")

# Get the store street names as locations
STORES=$(grep "</span><span class=\"normalText\">" <<< $WEBPAGE | cut -d ">" -f 3 | cut -d "&" -f 1) 
#echo $STORES
#grep "</span><span class=\"normalText\">" <<< $WEBPAGE | cut -d ">" -f 3 | cut -d "&" -f 1 > locations.txt

# Get the inventory as units 
UNITS=$(awk '/Units/{print $2}' <<< $WEBPAGE | sed 's/ /\n/g')
#echo $UNITS
#awk '/Units/{print $2}' <<< $WEBPAGE | sed 's/ /\n/g' > units.txt

# Combine locations and units to CSV
CSV_DATA=$(paste -d: <(echo "$STORES") <(echo "$UNITS") | paste -s -d, -)

# Put locations into CSV in line with date/time
echo "$FILE_DATE,$CSV_DATA" >> master.csv

