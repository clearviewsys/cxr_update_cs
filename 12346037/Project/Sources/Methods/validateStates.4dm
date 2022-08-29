//%attributes = {}
checkUniqueKey(->[States:61]; ->[States:61]StateCode:1; "StateCode")
checkIfNullString(->[States:61]StateName:3; "State or province name")
checkifRecordExists(->[Countries:62]; ->[Countries:62]CountryCode:1; ->[States:61]CountryCode:2; "Country Code")
