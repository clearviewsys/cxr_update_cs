C_BOOLEAN:C305($ok)
C_TEXT:C284($msg)
C_OBJECT:C1216($credentialsCheck)

$ok:=True:C214
$msg:=""

If (Form:C1466.credentials.username="")
	$ok:=False:C215
	$msg:="\n\nusername"
End if 

If (Form:C1466.credentials.password="")
	$ok:=False:C215
	$msg:=$msg+"\n\npassword"
End if 

If (Form:C1466.credentials.agentID="")
	$ok:=False:C215
	$msg:=$msg+"\n\nAgent ID"
End if 

If ($ok)
	
	$credentialsCheck:=mgSOAP_CheckCredentials(Form:C1466.credentials)
	
	If ($credentialsCheck.success)
		If (Form:C1466.credentials.deviceIDs#Null:C1517)
			OB REMOVE:C1226(Form:C1466.credentials; "deviceIDs")
		End if 
		ACCEPT:C269
	Else 
		$msg:="Error connecting to MoneyGram servers. Please, check your credentials and certificates\n\n"
		$msg:=$msg+mgGetSOAPErrorDetails($credentialsCheck.mgerrormsg)
		myAlert($msg)
	End if 
Else 
	myAlert("All fields are mandatory. You didn't provide "+$msg)
End if 
