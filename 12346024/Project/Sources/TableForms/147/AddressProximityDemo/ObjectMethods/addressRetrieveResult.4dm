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
		C_OBJECT:C1216($addressEntitiesObj; $errorObj; $addressObj)
		$errorObj:=New object:C1471
		$addressObj:=newAddress(arrAddressDetails{$selectedIndex}.countryIso2; arrAddressDetails{$selectedIndex}.provinceName; arrAddressDetails{$selectedIndex}.city; arrAddressDetails{$selectedIndex}.postalCode; $streetAddress; arrAddressDetails{$selectedIndex}.unitNumber)
		$success:=getAddressesNearAddress($addressObj; ->$addressEntitiesObj; $errorObj)
		If ($success=True:C214)
			C_TEXT:C284($message)
			If ($addressEntitiesObj.length>0)
				$message:=$message+" Found "+String:C10($addressEntitiesObj.length)+" proximity matches: "
				C_OBJECT:C1216($var)
				For each ($var; $addressEntitiesObj)
					$message:=$message+" "+$var.UnitNo+", "+$var.Address+", "+$var.City+", "+$var.ZipCode
					$message:=$message+"***"
				End for each 
			End if 
			
			$message:=$message+"********"
			//#ORDA
			$success:=getAddressesMatchingAddress($addressObj; ->$addressEntitiesObj)
			If ($addressEntitiesObj.length>0)
				$message:=$message+" Found "+String:C10($addressEntitiesObj.length)+" exact matches: "
				C_OBJECT:C1216($var)
				For each ($var; $addressEntitiesObj)
					$message:=$message+" "+$var.UnitNo+", "+$var.Address+", "+$var.City+", "+$var.ZipCode
					$message:=$message+"***"
				End for each 
			End if 
			myAlert($message)
			
		Else 
			myAlert(JSON Stringify:C1217($errorObj))
		End if 
		
End case 
