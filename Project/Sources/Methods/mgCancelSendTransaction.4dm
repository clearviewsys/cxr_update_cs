//%attributes = {}
// cancels MoneyGram send transaction if made today. Uses MG SOAP API. 
// Use Refund after today

C_TEXT:C284($1; $reason)  // one of: "NO_RCV_LOC", "WRONG_SERVICE", "NO_TQ", "INCORRECT_AMT" or "MS_NOT_USED"

//NO_RCV_LOC – No Receive Location
//WRONG_SERVICE – Wrong Transfer Service
//NO_TQ-Missing Test Question
//INCORRECT_AMT-Send/Receive Amount Is Incorrect
//MS_NOT_USED - MoveySaver card was not entered

C_TEXT:C284($2; $referenceNumber)
C_OBJECT:C1216($0; $parameters; $result; $mgCredentials)

$reason:=$1
$referenceNumber:=$2

$mgCredentials:=mgGetCredentials

$parameters:=New object:C1471("TransferCancelReason"; $reason; "TransferNumber"; $referenceNumber)

$result:=mgSOAP_RunMethod($mgCredentials; "SendCancel"; $parameters)

If ($result.success)
	
	If ($result.response#"")
		
		$result.sendCancel:=mgGetActionResult($result.response; "SendCancel")
		
	End if 
	
End if 

$0:=$result