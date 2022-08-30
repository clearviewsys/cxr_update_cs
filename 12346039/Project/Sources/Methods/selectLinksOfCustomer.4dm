//%attributes = {}
// selectLinksOfCustomer(customerID: text; destinationCountryCode : text) 
// this method selects the Links for a customer and destinationCountryCode including 'self' links
// self links: are links that have the same country code as the base company <>countryCode
// #ORDA ; #hybrid 
// TB : July 8 / 2021 
// Reason: this is supposed to replace selectLinksbyCustInCountry 

// POST: the Links selection changes ; this method does not select common links (links that are not linked to any customer


C_TEXT:C284($countryCode; $customerID; $1; $2)


Case of 
	: (Count parameters:C259=0)  // this is for backward compatibility with selectLinksbyCustInCountry
		$customerID:=[eWires:13]CustomerID:15
		$countryCode:=[eWires:13]toCountryCode:112
		
	: (Count parameters:C259=1)
		$customerID:=[eWires:13]CustomerID:15
		$countryCode:=$1
		
	: (Count parameters:C259=2)
		$customerID:=$1
		$countryCode:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
		
End case 

// find links belonging to customer including all links that are self

C_OBJECT:C1216($e1)
//[Links]countryCode
$e1:=ds:C1482.Links.query("CustomerID = :1 AND (countryCode = :2 OR countryCode = :3) order by FullName"; $customerID; $countryCode; <>countryCode)

If ($e1=Null:C1517)
	REDUCE SELECTION:C351([Links:17]; 0)
Else 
	USE ENTITY SELECTION:C1513($e1)
End if 



