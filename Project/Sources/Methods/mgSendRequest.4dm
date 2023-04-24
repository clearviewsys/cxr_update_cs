//%attributes = {}
// creates send MoneyGram transaction using SOAP API

C_OBJECT:C1216($1; $transaction)
C_OBJECT:C1216($0; $parameters; $result; $mgCredentials)

C_COLLECTION:C1488($resultCollection)

$transaction:=$1

// redunant properties removing, this shoud be removed once fixed from the calling method
If ($transaction.PromotionCode#Null:C1517)
	If ($transaction.PromotionCode="")
		OB REMOVE:C1226($transaction; "PromotionCode")
	End if 
End if 

$mgCredentials:=mgGetCredentials

C_BOOLEAN:C305($logmgSOAP)

$logmgSOAP:=mgLOG_isLoggingEnabled

If ($mgCredentials#Null:C1517)
	
	If ($logmgSOAP)
		mgLOG("SendRequest called using credentials "+JSON Stringify:C1217($mgCredentials; *)+" parameters "+JSON Stringify:C1217($transaction; *))
	End if 
	
	$result:=mgSOAP_Call($mgCredentials; "SendRequest"; $transaction)
	
	If ($result.success)
		
		If ($result.response#"")
			
			$result.result:=mgGetSendRequestResult($result.response)
			
		End if 
		
	Else 
		
		$result.mgerrormsg:=mgSOAP_GetErrorMsg($result.response)
		$result.mgerrormsg.httpcode:=$result.err
		
	End if 
	
End if 

$0:=$result

If ($logmgSOAP)
	mgLOG("SendRequest returned "+JSON Stringify:C1217($result; *))
End if 
