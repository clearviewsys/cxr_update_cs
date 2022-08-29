//%attributes = {}
// let's user enter MoneyGram credentials and store them in Storage

C_LONGINT:C283($winref)
C_OBJECT:C1216($credentials; $formObj)

If (mgIs4DClientAllowed)
	
	$credentials:=mgGetCredentialsFromKeyValues
	
	$formObj:=New object:C1471
	$formObj.credentials:=New object:C1471
	$formObj.credentials.deviceIDs:=$credentials.deviceIDs  // use just device IDs / Agent ID
	
	$winref:=Open form window:C675("mgEnterCredentials")
	DIALOG:C40("mgEnterCredentials"; $formObj)
	CLOSE WINDOW:C154
	
	If (OK=1)
		
		mgCredentialsStore($formObj.credentials)
		
	End if 
	
End if 
