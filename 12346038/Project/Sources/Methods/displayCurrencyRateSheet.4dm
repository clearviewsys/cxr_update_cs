//%attributes = {"shared":true}
If (isUserAllowedToUpdateRates)
	openFormWindow(->[Currencies:6]; "RateSheet")
Else 
	myAlert_AccessDenied
End if 