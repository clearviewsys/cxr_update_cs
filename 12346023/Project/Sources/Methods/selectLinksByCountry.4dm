//%attributes = {}
// selectLinksByCountry({country})
C_TEXT:C284($country; $1)

If (Count parameters:C259=0)
	$country:=vLinkCountry
Else 
	$country:=$1
End if 

QUERY:C277([Links:17]; [Links:17]Country:12=$country)  // filter only vAccountCurrency
