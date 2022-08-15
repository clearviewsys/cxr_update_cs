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
Form:C1466.Type:=""
Form:C1466.Address:=""
Form:C1466.UnitNo:=""
Form:C1466.State:=""
Form:C1466.City:=""
Form:C1466.ZipCode:=""
Form:C1466.CountryCode:=""
Form:C1466.Latitude:=0
Form:C1466.Longitude:=0

C_POINTER:C301($countryCodePtr)
C_TEXT:C284($countryCode3Digit; $countryCode2Digit)
$countryCodePtr:=OBJECT Get pointer:C1124(Object named:K67:5; "CountryCode")

$countryCode2Digit:=$countryCodePtr->

If ((Replace string:C233($searchTerm; " "; "")#"") & (Not:C34(Match regex:C1019(".*_.*"; $countryCode2Digit))))  //filter for country code input returns __ for empty value
	//Canada Post AddressComplete API requires 3 digit country code
	$countryCode3Digit:=getCountryCodeBy2charCode($countryCode2Digit)
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


