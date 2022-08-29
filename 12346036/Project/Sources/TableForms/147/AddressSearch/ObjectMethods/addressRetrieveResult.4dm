C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Clicked:K2:4)
		C_POINTER:C301($addressRetrieveResultComboPtr)
		$addressRetrieveResultComboPtr:=OBJECT Get pointer:C1124(Object current:K67:2)
		
		C_LONGINT:C283($selectedIndex)
		$selectedIndex:=$addressRetrieveResultComboPtr->
		
		//set the address entry fields for Addresses.Entry form
		[Addresses:147]Type:1:=arrAddressDetails{$selectedIndex}.type
		
		C_TEXT:C284($streetAddress)
		If (arrAddressDetails{$selectedIndex}.buildingNumber#"")
			$streetAddress:=String:C10(arrAddressDetails{$selectedIndex}.buildingNumber)+" "+arrAddressDetails{$selectedIndex}.street
		Else 
			$streetAddress:=arrAddressDetails{$selectedIndex}.street
		End if 
		[Addresses:147]Address:3:=$streetAddress
		
		[Addresses:147]UnitNo:15:=arrAddressDetails{$selectedIndex}.unitNumber
		[Addresses:147]State:5:=arrAddressDetails{$selectedIndex}.provinceName
		[Addresses:147]City:4:=arrAddressDetails{$selectedIndex}.city
		[Addresses:147]ZipCode:6:=arrAddressDetails{$selectedIndex}.postalCode
		[Addresses:147]CountryCode:7:=arrAddressDetails{$selectedIndex}.countryIso2
		
		//Note: hash values for address are set in trigger
		
		//if feature flag for google geocode is set, set the lat and long coordinates
		If (getKeyValue("address.enable.google.geocode"; "false")="true")
			C_OBJECT:C1216($geocodeResult; $errorObj)
			C_BOOLEAN:C305($success)
			$success:=googleGeocodeAddressString(Replace string:C233(arrAddressDetails{$selectedIndex}.label; "\n"; ", "); ->$geocodeResult; ->$errorObj)
			If ($success=True:C214)
				[Addresses:147]Latitude:13:=Num:C11($geocodeResult.lat)
				[Addresses:147]Longitude:14:=Num:C11($geocodeResult.lng)
			Else 
				myAlert(JSON Stringify:C1217($errorObj))
			End if 
		End if 
End case 
