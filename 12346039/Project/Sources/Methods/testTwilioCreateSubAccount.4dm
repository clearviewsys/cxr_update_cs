//%attributes = {}
C_POINTER:C301($pError)
C_TEXT:C284($message; $error; $sid; $name)
C_OBJECT:C1216($response)

$pError:=->$error
$message:="TestAccount"
//twilioCreateSubAccount ($pError)
//  //twilioCreateSubAccount ($pError;$message)
//  //$sid:=twilioCreateSubAccount ($pError;"Test Account 4")

//If ($error#"")
//myAlert ($error)
//End if 

//$name:=twilioGetSubAccountById ($pError;$sid)

//If ($error#"")
//myAlert ($error)
//End if 

//$response:=twilioGetSubAccountByName ($pError;"")//$name)

//If ($error#"")
//myAlert ($error)
//End if 

$response:=twilioGetAllSubAccounts($pError)

If ($error#"")
	myAlert($error)
End if 