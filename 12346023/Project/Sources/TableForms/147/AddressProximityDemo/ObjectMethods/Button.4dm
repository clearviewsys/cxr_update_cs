C_POINTER:C301($searchTextPtr; $addressSearchResultComboPtr; $addressRetrieveResultComboPtr)
$searchTextPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "searchText")
$addressSearchResultComboPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "addressSearchResult")
$addressRetrieveResultComboPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "addressRetrieveResult")

C_TEXT:C284($searchTerm)
$searchTerm:=$searchTextPtr->

ARRAY TEXT:C222($addressSearchResultComboPtr->; 0)  //clearing previous search results
ARRAY TEXT:C222($addressRetrieveResultComboPtr->; 0)
OBJECT SET VISIBLE:C603(*; "addressSearchResult"; False:C215)
OBJECT SET VISIBLE:C603(*; "addressRetrieveResult"; False:C215)

C_POINTER:C301($countryCodePtr)
C_TEXT:C284($countryCode3Digit)
$countryCodePtr:=OBJECT Get pointer:C1124(Object named:K67:5; "CountryCode")
$countryCode3Digit:=$countryCodePtr->

If ((Replace string:C233($searchTerm; " "; "")#"") & ($countryCode3Digit#"___"))  //filter for country code input returns ___ for empty value
	
	C_BOOLEAN:C305($success)
	ARRAY OBJECT:C1221(searchResult; 0)
	C_OBJECT:C1216($errorObj)
	
	$success:=CanPostAC_Search(->searchResult; $searchTerm; $countryCode3Digit; ->$errorObj)
	If ($success=True:C214)
		C_LONGINT:C283($i)
		For ($i; 1; Size of array:C274(searchResult))
			APPEND TO ARRAY:C911($addressSearchResultComboPtr->; searchResult{$i}.text+", "+searchResult{$i}.description)
		End for 
		OBJECT SET VISIBLE:C603(*; "addressSearchResult"; True:C214)
	Else 
		If ($errorObj#Null:C1517)
			myAlert(JSON Stringify:C1217($errorObj; *))
		End if 
	End if 
	
End if 


