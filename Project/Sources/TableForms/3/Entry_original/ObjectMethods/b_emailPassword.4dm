checkInit
checkIfNullString(->[Customers:3]obs_password:48; "Password cannot be empty")
checkIfNullString(->[Customers:3]Email:17; "Please enter a valid email")
checkAddWarning("The customer's password will be sent via email to "+[Customers:3]Email:17)

C_TEXT:C284($body)
If (isValidationConfirmed)
	$body:="Hello "+[Customers:3]FullName:40+","+Char:C90(LF ASCII code:K15:11)
	$body:=$body+"Your Login ID is: "+[Customers:3]CustomerID:1+Char:C90(LF ASCII code:K15:11)
	$body:=$body+"Your Password is: "+[Customers:3]obs_password:48+Char:C90(LF ASCII code:K15:11)
	$body:=$body+"You may login by going to : "+<>CompanyWebAddress
	C_LONGINT:C283($error)
	$error:=sendEmail([Customers:3]Email:17; "Confidential from "+<>companyName; $body)
	
	If ($error#0)
		myAlert("There was an error sending the email")
	End if 
	
End if 