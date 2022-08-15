C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Clicked:K2:4)
		C_POINTER:C301($addressRetrieveResultComboPtr)
		$addressRetrieveResultComboPtr:=OBJECT Get pointer:C1124(Object current:K67:2)
		
		C_LONGINT:C283($selectedIndex)
		$selectedIndex:=$addressRetrieveResultComboPtr->
		
		//set the address entry fields for Addresses.Entry form
		Form:C1466.Type:=arrAddressDetails{$selectedIndex}.type
		
		C_TEXT:C284($streetAddress)
		If (arrAddressDetails{$selectedIndex}.buildingNumber#"")
			$streetAddress:=String:C10(arrAddressDetails{$selectedIndex}.buildingNumber)+" "+arrAddressDetails{$selectedIndex}.street
		Else 
			$streetAddress:=arrAddressDetails{$selectedIndex}.street
		End if 
		Form:C1466.Address:=$streetAddress
		
		Form:C1466.UnitNo:=arrAddressDetails{$selectedIndex}.unitNumber
		Form:C1466.State:=arrAddressDetails{$selectedIndex}.provinceName
		Form:C1466.City:=arrAddressDetails{$selectedIndex}.city
		Form:C1466.ZipCode:=arrAddressDetails{$selectedIndex}.postalCode
		Form:C1466.CountryCode:=arrAddressDetails{$selectedIndex}.countryIso2
		
		//Note: hash values for address are set in trigger
		
		//if feature flag for google geocode is set, set the lat and long coordinates
		If (getKeyValue("address.enable.google.geocode"; "false")="true")
			C_OBJECT:C1216($geocodeResult; $errorObj)
			C_BOOLEAN:C305($success)
			$success:=googleGeocodeAddressString(Replace string:C233(arrAddressDetails{$selectedIndex}.label; "\n"; ", "); ->$geocodeResult; ->$errorObj)
			If ($success=True:C214)
				Form:C1466.Latitude:=Num:C11($geocodeResult.lat)
				Form:C1466.Longitude:=Num:C11($geocodeResult.lng)
				
				//show google map
				OBJECT SET VISIBLE:C603(*; "GoogleMap"; True:C214)
				
				C_TEXT:C284($templateHtmlPath; $renderedHtmlPath; $htmlContent)
				
				$templateHtmlPath:=Get 4D folder:C485(Current resources folder:K5:16; *)+"google-map-templates"+Folder separator:K24:12+"map_location_template.html"
				$renderedHtmlPath:=Get 4D folder:C485(Current resources folder:K5:16; *)+"google-map-templates"+Folder separator:K24:12+"map_location_rendered.html"
				
				If (Test path name:C476($templateHtmlPath)=Is a document:K24:1)
					C_TEXT:C284($googleApiKey)
					$googleApiKey:=getKeyValue("Google.geocode.api.key")
					$htmlContent:=Document to text:C1236($templateHtmlPath)
					$htmlContent:=Replace string:C233($htmlContent; "<LAT>"; String:C10($geocodeResult.lat))
					$htmlContent:=Replace string:C233($htmlContent; "<LNG>"; String:C10($geocodeResult.lng))
					$htmlContent:=Replace string:C233($htmlContent; "<API_KEY>"; $googleApiKey)
					C_TIME:C306(vhDoc)
					vhDoc:=Open document:C264($renderedHtmlPath; Write mode:K24:4)
					If (OK=1)
						SEND PACKET:C103(vhDoc; $htmlContent)
						CLOSE DOCUMENT:C267(vhDoc)
						WA OPEN URL:C1020(*; "GoogleMap"; $renderedHtmlPath)
					End if 
				End if 
			Else 
				myAlert(JSON Stringify:C1217($errorObj))
			End if 
		End if 
End case 
