//%attributes = {"publishedWeb":true}

//<>TO convert queryies to ORDA b/c of @ sign
checkUniqueness(->[WebUsers:14]; ->[WebUsers:14]webUsername:1; ->webUserName; "Username")
checkIfNullString(->webPassword; "Password")
checkUniqueness(->[WebUsers:14]; ->[WebUsers:14]Email:3; ->webEmail; "eMail")
