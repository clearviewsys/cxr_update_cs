//%attributes = {"shared":true}
If (isUserAdministrator)
	handleAdministrationButton
Else 
	myAlert("Sorry, you are not authorized to access this panel.")
End if 