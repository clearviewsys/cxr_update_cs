//%attributes = {}
// populateCountries_ISO3166

// this will populate the Countries table with North American CountryName Classification System (6 digits only)

// ([Countries];"Listbox")

ARRAY TEXT:C222($arrCodes; 0)
ARRAY TEXT:C222($arrCountries; 0)

ALL RECORDS:C47([Countries:62])
SELECTION TO ARRAY:C260([Countries:62]CountryCode:1; $arrCodes; [Countries:62]CountryName:2; $arrCountries)

populateCountryArrays_ISO3166(->$arrCodes; ->$arrCountries)

ARRAY TO SELECTION:C261($arrCodes; [Countries:62]CountryCode:1; $arrCountries; [Countries:62]CountryName:2)
UNLOAD RECORD:C212([Countries:62])

READ ONLY:C145([Countries:62])

allRecordsCountries