//%attributes = {}
// returns the status of transaction
C_TEXT:C284($1; $referenceNumber)
C_COLLECTION:C1488($statuses; $found)
C_OBJECT:C1216($0; $parameters; $result; $mgCredentials; $webeWire)

$referenceNumber:=$1

$statuses:=mgGetStatuses
$mgCredentials:=mgGetCredentials

If ($mgCredentials#Null:C1517)
	
	$webeWire:=ds:C1482.WebEWires.query("paymentInfo.result.referenceNumber = :1"; $referenceNumber).first()
	
	If ($webeWire#Null:C1517)
		
		If ($webeWire.paymentInfo.result.transactionType="Send")
			$parameters:=New object:C1471("TransferNumber"; $referenceNumber; "TransferSearchMode"; 1; "SynchronizeTransfer"; True:C214)
		Else 
			$parameters:=New object:C1471("TransferNumber"; $referenceNumber; "TransferSearchMode"; 0; "SynchronizeTransfer"; True:C214)
		End if 
		
		$result:=mgSOAP_RunMethod($mgCredentials; "GetTransfer"; $parameters)
		
		$found:=$statuses.query("statusCode = :1"; Num:C11($result.transferState))
		
		$0:=$result
		
		If ($found.length>0)
			$0.found:=$found[0]
		End if 
		
	End if 
	
End if 
