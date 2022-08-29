C_LONGINT:C283($validStatus)
C_TEXT:C284($email)

$email:=[Customers:3]Email:17

If (($email="") | (isValidEmailFormat($email)=False:C215))
	myAlert("Email not formatted correctly, enter an email in a valid format")
Else 
	
	$validStatus:=isEmailValid([Customers:3]Email:17)
	
	If ($validStatus=1)
		myAlert("The email is Valid")
	End if 
	
	If ($validStatus=2)
		myAlert("This email is not Valid, please enter a valid email address")
		[Customers:3]Email:17:=""
	End if 
End if 
