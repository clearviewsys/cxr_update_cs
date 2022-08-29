//%attributes = {"shared":true}
If (isUserAllowedToViewProfits)
	openFormWindow(->[Currencies:6]; "holdings")
Else 
	myAlert("Sorry, please ask the administrator to allow you to view this form.")
End if 