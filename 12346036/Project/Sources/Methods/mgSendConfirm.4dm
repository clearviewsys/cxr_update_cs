//%attributes = {}
// confirms MoneyGram send transaction created using SOAP API

C_TEXT:C284($1; $transferSysId)
C_OBJECT:C1216($0; $parameters; $result; $mgCredentials)

$transferSysId:=$1

$mgCredentials:=mgGetCredentials

$parameters:=New object:C1471("TransferSysId"; $transferSysId)

$result:=mgSOAP_RunMethod($mgCredentials; "SendConfirm"; $parameters)

If ($result.success)
	If ($result.response#"")
		$result.sendConfirm:=mgGetActionResult($result.response; "SendConfirm")
	End if 
End if 

$0:=$result
