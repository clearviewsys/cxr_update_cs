C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Clicked:K2:4)
		C_POINTER:C301($addressRetrieveResultComboPtr)
		$addressRetrieveResultComboPtr:=OBJECT Get pointer:C1124(Object current:K67:2)
		
		C_LONGINT:C283($selectedIndex)
		$selectedIndex:=$addressRetrieveResultComboPtr->
		
		C_TEXT:C284($streetAddress)
		If (arrAddressDetails{$selectedIndex}.buildingNumber#"")
			$streetAddress:=String:C10(arrAddressDetails{$selectedIndex}.buildingNumber)+" "+arrAddressDetails{$selectedIndex}.street
		Else 
			$streetAddress:=arrAddressDetails{$selectedIndex}.street
		End if 
		
		C_BOOLEAN:C305($success)
		C_OBJECT:C1216($customerEntitySelectionObj; $errorObj; $addressObj)
		C_TEXT:C284($message)
		$addressObj:=newAddress(arrAddressDetails{$selectedIndex}.countryIso2; arrAddressDetails{$selectedIndex}.provinceName; arrAddressDetails{$selectedIndex}.city; arrAddressDetails{$selectedIndex}.postalCode; $streetAddress; arrAddressDetails{$selectedIndex}.unitNumber)
		getCustomersMatchingAddress($addressObj; ->$customerEntitySelectionObj)
		If ($customerEntitySelectionObj.length>0)
			$message:=$message+" Found "+String:C10($customerEntitySelectionObj.length)+" customer(s) in that exact address: "
			C_OBJECT:C1216($var)
			For each ($var; $customerEntitySelectionObj)
				$message:=$message+"ID: "+$var.CustomerID+", Full Name: "+$var.FullName+"*****"
			End for each 
			$message:=$message+"#########"
		End if 
		
		$errorObj:=New object:C1471
		$customerEntitySelectionObj:=New object:C1471
		$success:=getCustomersNearAddress($addressObj; ->$customerEntitySelectionObj; $errorObj)
		If ($success=True:C214)
			If ($customerEntitySelectionObj.length>0)
				$message:=$message+" Found "+String:C10($customerEntitySelectionObj.length)+" customer(s) near that address: "
				C_OBJECT:C1216($var)
				For each ($var; $customerEntitySelectionObj)
					$message:=$message+"ID: "+$var.CustomerID+", Full Name: "+$var.FullName+"*****"
				End for each 
			End if 
		Else 
			If (OB Is defined:C1231($errorObj; "error_message"))
				myAlert("Error: "+String:C10($errorObj.error_message))
			End if 
		End if 
		
		If ($message#"")
			myAlert($message)
		End if 
		
End case 
