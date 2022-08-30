//%attributes = {}
checkIfNullString(->[Agents:22]FullName:6; "Full Name")
checkIfNullString(->[Agents:22]AgentID:1; "Login ID")
checkIfNullString(->[Agents:22]City:3; "City")
checkIfNullString(->[Agents:22]Province:4; "Province/State"; "Warn")
checkIfNullString(->[Agents:22]PostalCode:22; "Zip Code/Postal Code"; "Warn")
checkIfNullString(->[Agents:22]LocationNumber:23; "Location Number"; "Warn")

checkIfNullString(->[Agents:22]CountryCode:21; "Country Code")
//checkIfNullString (->[Agents]Password;"Password")
//checkUniqueness (->[WebUsers];->[WebUsers]LoginID;->[Agents]LoginID;"Login ID")

checkUniqueKey(->[Agents:22]; ->[Agents:22]AgentID:1; "Login ID")

If ([Agents:22]isAllowedAccess:7=False:C215)
	//checkAddWarning ("This Agent will not be able to login if you do not grant access")
End if 