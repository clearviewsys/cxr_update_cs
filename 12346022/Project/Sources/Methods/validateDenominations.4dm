//%attributes = {}
[Denominations:31]DenominationID:1:=makeDenominationsID
checkUniqueKey(->[Denominations:31]; ->[Denominations:31]DenominationID:1; "The denomination "+[Denominations:31]DenominationID:1)
checkIfNullString(->[Denominations:31]Currency:2; "Currency Code")
checkGreaterThan(->[Denominations:31]Value:3; "Denomanation Value"; 0)