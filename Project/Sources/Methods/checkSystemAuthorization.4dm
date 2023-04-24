//%attributes = {}
setErrorTrap("checkSystemAuthorization")
If (Not:C34(isSystemAuthorized))
	If (User in group:C338(Current user:C182; "Designers"))
		myAlert("This workstation is not authorized.")
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
