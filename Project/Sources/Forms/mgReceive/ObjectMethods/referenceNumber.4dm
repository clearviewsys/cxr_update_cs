C_OBJECT:C1216($webEwire; $status; $parameters; $mgCredentials; $state)
C_COLLECTION:C1488($statuses; $found)
C_TEXT:C284($findState; $msg)

$webEwire:=ds:C1482.WebEWires.query("paymentInfo.result.referenceNumber = :1"; Form:C1466.object.referenceNumber).first()

OBJECT SET ENABLED:C1123(*; "btn_receive"; False:C215)

If ($webEwire#Null:C1517)
	
	myAlert("Transfer with reference number "+Form:C1466.object.referenceNumber+" already exists in local database!")
	Form:C1466.object.referenceNumber:=""
	
Else 
	
	$mgCredentials:=Form:C1466.credentials
	$parameters:=New object:C1471("TransferNumber"; Form:C1466.object.referenceNumber; "TransferSearchMode"; 0)
	
	SET WINDOW TITLE:C213("Checking reference number with MoneyGram SOAP API...")
	
	$state:=mgSOAP_RunMethod($mgCredentials; "GetTransfer"; $parameters)
	
	
	If ($state.success)
		
		$msg:="No results returned"
		
		If ($state.result#Null:C1517)
			
			If ($state.result.length>0)
				
				$msg:="Couldn't get transfer state"
				
				If ($state.result[0].TransferState#Null:C1517)
					
					
					$findState:=$state.result[0].TransferState
					
					If (($findState="40") | ($findState="65"))
						
						OBJECT SET ENABLED:C1123(*; "btn_receive"; True:C214)
						
					Else 
						
						$statuses:=mgGetStatuses
						$found:=$statuses.query("statusCode = :1"; Num:C11($findState))
						
						If ($found#Null:C1517)
							If ($found.length>0)
								$msg:="Status of transaction with reference number "+Form:C1466.object.referenceNumber
								$msg:=$msg+" returned by MoneyGram SOAP API is code "
								$msg:=$msg+String:C10($found[0].statusCode)+" "+$found[0].status
								$msg:=$msg+"\n\nFull transfer information:\n\n"+JSON Stringify:C1217($state.result[0]; *)
								SET WINDOW TITLE:C213("Transaction status: "+String:C10($found[0].statusCode)+" "+$found[0].status)
								myAlert($msg)
								
							End if 
						End if 
						
					End if 
					
				End if 
			End if 
		End if 
		
		SET WINDOW TITLE:C213("   ")
		
	Else 
		
		If ($state.mgerrormsg.message#Null:C1517)
			myAlert("MoneyGram SOAP API returned "+$state.mgerrormsg.message)
			SET WINDOW TITLE:C213($state.mgerrormsg.message)
		Else 
			SET WINDOW TITLE:C213("Couldn't contact MoneyGram SOAP API")
		End if 
		
	End if 
End if 
