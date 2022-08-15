//%attributes = {"shared":true}
If (isUserAdministrator)
	
	If (Application type:C494=4D Local mode:K5:1)
		OPEN SECURITY CENTER:C1018
		// ...
	End if 
	If (Application type:C494=4D Remote mode:K5:5)
		OPEN ADMINISTRATION WINDOW:C1047
		// ...
	End if 
	If (Application type:C494=4D Server:K5:6)
		// ...
		OPEN SECURITY CENTER:C1018
	End if 
Else 
	myAlert("Please sign-in as Administrator first.")
End if 