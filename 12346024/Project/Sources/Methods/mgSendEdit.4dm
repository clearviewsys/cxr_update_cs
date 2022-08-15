//%attributes = {}
// changes the name of beneficiary - send transaction only
C_TEXT:C284($1; $referenceNumber)
C_OBJECT:C1216($2; $names)
C_COLLECTION:C1488($statuses; $found)
C_OBJECT:C1216($0; $parameters; $result; $mgCredentials; $webeWire)
C_LONGINT:C283($i)
C_BOOLEAN:C305($ok)

ASSERT:C1129(Count parameters:C259>=2; "Missing parameters")

$referenceNumber:=$1
$names:=$2

$mgCredentials:=mgGetCredentials

$webeWire:=ds:C1482.WebEWires.query("paymentInfo.result.referenceNumber = :1"; $referenceNumber).first()

If ($webeWire#Null:C1517)
	
	If ($webeWire.paymentInfo.result.transactionType="Send")
		
		$ok:=False:C215
		
		If ($names.ReceiverLastName#Null:C1517)
			If ($names.ReceiverLastName#"")
				If ($names.ReceiverName#Null:C1517)
					If ($names.ReceiverName#"")
						$ok:=True:C214
					End if 
				End if 
			End if 
		End if 
		
		If ($ok)
			
			$parameters:=New object:C1471("TransferNumber"; $referenceNumber)
			
			ARRAY TEXT:C222($properties; 0)
			OB GET PROPERTY NAMES:C1232($names; $properties)
			
			For ($i; 1; Size of array:C274($properties))
				$parameters[$properties{$i}]:=$names[$properties{$i}]
			End for 
			
			$result:=mgSOAP_RunMethod($mgCredentials; "SendEdit"; $parameters)
			
			// SET TEXT TO PASTEBOARD($result.response)
			
			$0:=$result
			
		Else 
			
			// mandatory parameters not present
			$0.success:=False:C215
			
		End if 
		
	Else 
		
		// do nothing, only valid for send transactions
		
		$0.success:=False:C215
		
	End if 
	
End if 
