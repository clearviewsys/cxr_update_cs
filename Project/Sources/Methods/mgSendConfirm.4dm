//%attributes = {}
// confirms MoneyGram send transaction created using SOAP API

C_TEXT:C284($1; $transferSysId)
C_OBJECT:C1216($2; $mgCredentials)
C_OBJECT:C1216($0; $parameters; $result)

$transferSysId:=$1

If (Count parameters:C259>=2)
	$mgCredentials:=$2
Else 
	$mgCredentials:=mgGetCredentials
End if 

$parameters:=New object:C1471("TransferSysId"; $transferSysId)

$result:=mgSOAP_RunMethod($mgCredentials; "SendConfirm"; $parameters)

If ($result.success)
	If ($result.response#"")
		$result.sendConfirm:=mgGetActionResult($result.response; "SendConfirm")
	End if 
End if 

$0:=$result

C_BOOLEAN:C305($logmgSOAP)

$logmgSOAP:=mgLOG_isLoggingEnabled

If ($logmgSOAP)
	mgLOG("SendConfirm returned "+JSON Stringify:C1217($result; *))
End if 
