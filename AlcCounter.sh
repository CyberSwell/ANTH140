#!/bin/bash

var=`date +"%FORMAT_STRING"`
now=`date +"%Y-%m-%d-%H-%M"`
FILE_NAME=$now

curl -s "https://www.finewineandgoodspirits.com/webapp/wcs/stores/servlet/StoreStateSearch?storeId=10051&langId=-1&catalogId=10051&ItemCode=000004249&SearchNow=on&ProdName=Crown+Russe+Vodka+80+Proof&fromURL=%2Fwebapp%2Fwcs%2Fstores%2Fservlet%2FCatalogSearchResultView%3FstoreId%3D10051%26catalogId%3D10051%26langId%3D-1%26sType%3DSimpleSearch%26resultCatEntryType%3D2%26showResultsPage%3Dtrue%26pageSize%3D15%26sortBy%3D5%26searchSource%3DQ%26pageView%3D%26beginIndex%3D0%26searchTerm%3DCrown%26SearchKeyWord%3DCrown&countyName=Centre&f=&storeName=&pageNum=&perPage=&storeType=&city=&zip_code=&county=14&storeNO=" | grep "Units" | awk '{print $2}'> ./webPages/"$FILE_NAME"
