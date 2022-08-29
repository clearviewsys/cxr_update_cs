C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388

Case of 
	: (($formEvent=On Data Change:K2:15) | ($formEvent=On Clicked:K2:4))
		C_POINTER:C301($addressSearchResultComboPtr)
		$addressSearchResultComboPtr:=OBJECT Get pointer:C1124(Object current:K67:2)
		C_LONGINT:C283($selectedIndex)
		$selectedIndex:=$addressSearchResultComboPtr->
		
		C_TEXT:C284($selectedAddressId)
		$selectedAddressId:=searchResult{$selectedIndex}.id
		
		//clear details dropdown
		$addressRetrieveResultComboPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "addressRetrieveResult")
		ARRAY TEXT:C222($addressRetrieveResultComboPtr->; 0)
		
		//retrieve details for selected address ID
		C_BOOLEAN:C305($success)
		ARRAY OBJECT:C1221(arrAddressDetails; 0)
		C_OBJECT:C1216($errorObj)
		$success:=CanPostAC_RetrieveAddress(->arrAddressDetails; $selectedAddressId; ->$errorObj)
		If ($success=True:C214)
			C_POINTER:C301($addressRetrieveResultComboPtr)
			$addressRetrieveResultComboPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "addressRetrieveResult")
			C_LONGINT:C283($i)
			For ($i; 1; Size of array:C274(arrAddressDetails))
				APPEND TO ARRAY:C911($addressRetrieveResultComboPtr->; Replace string:C233(arrAddressDetails{$i}.label; "\n"; ", "))  //replacing \n with comma in label
			End for 
			OBJECT SET VISIBLE:C603(*; "addressRetrieveResult"; True:C214)
		Else 
			ARRAY TEXT:C222($addressRetrieveResultComboPtr->; 0)
			OBJECT SET VISIBLE:C603(*; "addressRetrieveResult"; False:C215)
			If ($errorObj#Null:C1517)
				myAlert(JSON Stringify:C1217($errorObj; *))
			End if 
		End if 
		
End case 
