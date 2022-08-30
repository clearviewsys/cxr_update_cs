//%attributes = {}

// Method: XLIFF_SetKeywords ( ->Array )



C_POINTER:C301($1; $keywordsTypes)
$keywordsTypes:=$1


APPEND TO ARRAY:C911($keywordsTypes->; "common")
APPEND TO ARRAY:C911($keywordsTypes->; "fields")
APPEND TO ARRAY:C911($keywordsTypes->; "forms")
APPEND TO ARRAY:C911($keywordsTypes->; "errors")
APPEND TO ARRAY:C911($keywordsTypes->; "countries")
APPEND TO ARRAY:C911($keywordsTypes->; "tables")
APPEND TO ARRAY:C911($keywordsTypes->; "myalert")
APPEND TO ARRAY:C911($keywordsTypes->; "myconfirm")
APPEND TO ARRAY:C911($keywordsTypes->; "confirm")
APPEND TO ARRAY:C911($keywordsTypes->; "alert")
APPEND TO ARRAY:C911($keywordsTypes->; "selectfolder")




$keywordsTypes->:=1

//CLEAR SET("$keywords")

