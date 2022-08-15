//%attributes = {}
setErrorTrap("checkSystemAuthorization")
If (Not:C34(isSystemAuthorized))
	If (User in group:C338(Current user:C182; "Designers"))
		If (Application type:C494=4D Server:K5:6)  // Modified by: Barclay (2/2/2012)
			//no dialog on server
		Else 
			myAlert("This workstation is not authorized.")
		End if 
		displayList_MACs
		//If (Not(isSystemAuthorized ))
		//forceQuit 
		//End if 
	Else 
		//ALERT("Please contact the provider to authorize this software.")
		//SMS_notifyTiran ("License expired for "+<>companyName+": "+getCurrentMachineName )
		displayEmergencyActivationForm
	End if 
End if 
endErrorTrap
