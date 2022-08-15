//%attributes = {}
// returns tranfer created using SendRequest which returned $1 as Confirmation number

C_TEXT:C284($1; $formFreeStageNum)
C_TEXT:C284($2; $transferAmount)
C_OBJECT:C1216($0; $parameters; $result; $mgCredentials)

$formFreeStageNum:=$1
$transferAmount:=$2

$mgCredentials:=mgGetCredentials

If ($mgCredentials#Null:C1517)
	
	$parameters:=New object:C1471("FormFreeStaging"; $formFreeStageNum; \
		"TransferSearchMode"; 4; "TransferSendAmount"; $transferAmount)
	
	$result:=mgSOAP_RunMethod($mgCredentials; "GetTransfer"; $parameters)
	
	$0:=$result
	
End if 
