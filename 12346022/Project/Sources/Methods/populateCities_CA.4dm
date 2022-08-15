//%attributes = {}
// populateCities_CA

// this will populate the Cities table with all cities of Canada
// ([Cities];"Listbox")

populateProvinces_CA  // first populate the provinces of canada
ARRAY TEXT:C222($arrKeys; 0)
ARRAY TEXT:C222($arrValues; 0)
ARRAY TEXT:C222($arrCA; 0)
C_LONGINT:C283($i; $n)

ALL RECORDS:C47([Cities:60])

SELECTION TO ARRAY:C260([Cities:60]StateCode:2; $arrKeys; [Cities:60]CityName:1; $arrValues)
populateCitiesArrays_CA(->$arrKeys; ->$arrValues)
$n:=Size of array:C274($arrValues)
ARRAY TEXT:C222($arrCA; $n)
For ($i; 1; $n)  // fill array of country codes
	$arrCA{$i}:="CA"  // Canada
End for 
ARRAY TO SELECTION:C261($arrKeys; [Cities:60]StateCode:2; $arrValues; [Cities:60]CityName:1; $arrCA; [Cities:60]CountryCode:4)

UNLOAD RECORD:C212([Cities:60])
READ ONLY:C145([Cities:60])