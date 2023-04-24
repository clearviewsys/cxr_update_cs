//%attributes = {}




C_TEXT:C284($1; $tToCountry)
C_POINTER:C301($2)  //option - pointer to array to fill
C_POINTER:C301($3)  //option value
C_POINTER:C301($4)  //option label

$tToCountry:=$1

If ($tToCountry="AU") | ($tToCountry="FJ") | ($tToCountry="NZ")
	APPEND TO ARRAY:C911($2->; "Cash Pickup")
	APPEND TO ARRAY:C911($3->; "D")
	
	APPEND TO ARRAY:C911($2->; "Mobile Wallet")
	APPEND TO ARRAY:C911($3->; "N-M")
End if 

APPEND TO ARRAY:C911($2->; "Bank Transfer")
APPEND TO ARRAY:C911($3->; "N")

If (Choose:C955(getKeyValue("web.customers.webewires.tomop.moneygram")=""; False:C215; True:C214))  //only use if defined
	APPEND TO ARRAY:C911($2->; "MoneyGram")
	APPEND TO ARRAY:C911($3->; "MG")
End if 


