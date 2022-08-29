//%attributes = {}
// populateCities_NZ

// this will populate the Cities table with all cities of NEw Zealand
// ([Cities];"Listbox")

ARRAY TEXT:C222($arrKeys; 0)
ARRAY TEXT:C222($arrValues; 0)
C_LONGINT:C283($i; $n)

ALL RECORDS:C47([Cities:60])

SELECTION TO ARRAY:C260([Cities:60]CountryCode:4; $arrKeys; [Cities:60]CityName:1; $arrValues)
populateCitiesArrays_NZ(->$arrKeys; ->$arrValues)
ARRAY TO SELECTION:C261($arrKeys; [Cities:60]CountryCode:4; $arrValues; [Cities:60]CityName:1)

UNLOAD RECORD:C212([Cities:60])
READ ONLY:C145([Cities:60])