C_LONGINT:C283($winref)
C_OBJECT:C1216($formObj; $deliveryOption; $validated; $result; $paramaters; $methodInfo; \
$formMissing; $missingAllValidated)
C_TEXT:C284($webewireID; $msg)

If ((Form:C1466.credentials.username#"") & (Form:C1466.credentials.password#"") & (Form:C1466.credentials.agentID#""))
	
	// get delivery options first, DeliveryOptionID is required for SendRequest
	
	$validated:=mgValidateAll(Form:C1466)
	
	If ($validated.success)
		
		$formObj:=New object:C1471
		$formObj.destinationCountry:=Form:C1466.object.destinationCountry
		$formObj.sendCurrency:=Form:C1466.object.sendCurrency
		$formObj.sendAmount:=Num:C11(Form:C1466.object.sendAmount)
		$formObj.fromSend:=True:C214
		
		$winref:=Open form window:C675("mgQuote")
		DIALOG:C40("mgQuote"; $formObj)
		
		CLOSE WINDOW:C154
		
		If (OK=1)  // send button clicked in quote form
			
			$deliveryOption:=$formObj.currDeliveryOption
			
			SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($deliveryOption; *))
			
			$paramaters:=mgBuildSendRequestTransaction(Form:C1466.object; $deliveryOption)
			
			If (Form:C1466.stageTransfer)
				$paramaters.FormFreeStaging:="True"
			End if 
			
			$methodInfo:=mgGetSendRequestMethodInfo($deliveryOption)
			
			If ($methodInfo.success)
				
				$missingAllValidated:=mgHndlSendRequestMissingParams($methodInfo.response; $paramaters; Form:C1466.customerID)
				
				If ($missingAllValidated.success)
					
					$result:=mgSendRequest($paramaters)
					
					If ($result.success)
						
						$webewireID:=mgSendRequestCreateWebewire($paramaters; $result; Form:C1466.customerID)
						
						ACCEPT:C269
						
					Else 
						
						$msg:=mgGetSOAPErrorDetails($result.mgerrormsg)
						
						myAlert($msg)
						
					End if 
					
				End if 
				
			End if 
			
		End if 
		
	End if 
	
End if 
