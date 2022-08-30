If (emergencyActivate)
	ACCEPT:C269
	ALERT:C41("Please call Clear View Systems now and activate the license.")
	
Else 
	ALERT:C41("No more activation allowed on this computer")
	
	If (Shift down:C543)
		//backdoor
		ACCEPT:C269  //close the window
		C_TEXT:C284($tPassword)
		$tPassword:=Request:C163("CXR Support: Enter emergency code.")
		
		If (Validate password:C638(1; $tPassword))  //all good
			
		Else 
			QUIT 4D:C291
		End if 
	Else 
		QUIT 4D:C291
	End if 
End if 