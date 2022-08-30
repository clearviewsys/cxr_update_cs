//%attributes = {}

//web user accounts are created on the web now
If (True:C214)
	checkIfNullString(->[WebUsers:14]webUsername:1; "Login ID")
	checkIfNullString(->[WebUsers:14]Password:2; "Password")
Else 
	checkIfNullString(->[WebUsers:14]webUsername:1; "Login ID")
	checkIfNullString(->[WebUsers:14]Password:2; "Password")
	checkIfNullString(->[WebUsers:14]confirmationToken:6; "Confirmation Token")
	checkIfNullString(->[WebUsers:14]countryCode:7; "Country")
End if 