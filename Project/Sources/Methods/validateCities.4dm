//%attributes = {}
//checkUniqueKey (->[Cities];->[Cities]CityName;"Name of City")
checkIfNullString(->[Cities:60]CityName:1; "City")
checkIfNullString(->[Cities:60]CountryCode:4; "Country Code")
checkifRecordExists(->[Countries:62]; ->[Countries:62]CountryCode:1; ->[Cities:60]CountryCode:4; "Country Code")
