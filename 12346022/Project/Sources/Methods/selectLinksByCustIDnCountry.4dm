//%attributes = {}
// selectLinksByCustIDnCountry
// modified by TB on July 8/2021

If (True:C214)  // new way
	If (Count parameters:C259=1)
		selectLinksOfCustomer($1)
	Else 
		selectLinksOfCustomer  //([eWires]toCountryCode)
	End if 
	
	
Else 
	// old code is here
	
	
	C_TEXT:C284($countryCode; $1)
	If (Count parameters:C259=1)
		$countryCode:=$1
	Else 
		$countryCode:=[eWires:13]toCountryCode:112
	End if 
	
	QUERY:C277([Links:17]; [Links:17]CustomerID:14=[eWires:13]CustomerID:15; *)  // select links belongin to the same customer and in the country of destination
	QUERY:C277([Links:17];  & ; [Links:17]countryCode:50=$countryCode; *)
	//QUERY([Links]; | ;[Links]countryCode=<>CountryCode)  // 
	
	
	
	CREATE SET:C116([Links:17]; "$links")
	SET QUERY DESTINATION:C396(Into set:K19:2; "$unlinked")
	
	
	QUERY:C277([Links:17]; [Links:17]CustomerID:14=""; *)
	QUERY:C277([Links:17]; [Links:17]countryCode:50=$countryCode)
	
	
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	UNION:C120("$links"; "$unlinked"; "$links")
	USE SET:C118("$links")
	CLEAR SET:C117("$links")
	CLEAR SET:C117("$unlinked")
	
	ORDER BY:C49([Links:17]; [Links:17]FullName:4; >)
End if 