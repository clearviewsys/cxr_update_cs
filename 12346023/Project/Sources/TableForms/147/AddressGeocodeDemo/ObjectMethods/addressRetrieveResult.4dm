C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Clicked:K2:4)
		C_POINTER:C301($addressRetrieveResultComboPtr)
		$addressRetrieveResultComboPtr:=OBJECT Get pointer:C1124(Object current:K67:2)
		
		C_LONGINT:C283($selectedIndex)
		$selectedIndex:=$addressRetrieveResultComboPtr->
		
		C_OBJECT:C1216($geocodeResult; $errorObj)
		C_BOOLEAN:C305($success)
		C_TEXT:C284($googleApiKey)
		$googleApiKey:=getKeyValue("Google.geocode.api.key")
		$success:=googleGeocodeAddressString(Replace string:C233(arrAddressDetails{$selectedIndex}.label; "\n"; ", "); ->$geocodeResult; ->$errorObj; $googleApiKey)
		If ($success=True:C214)
			OBJECT SET VISIBLE:C603(*; "GoogleMap"; True:C214)
			
			C_TEXT:C284($templateHtmlPath; $renderedHtmlPath; $htmlContent)
			
			$templateHtmlPath:=Get 4D folder:C485(Current resources folder:K5:16; *)+"google-map-templates"+Folder separator:K24:12+"map_location_template.html"
			$renderedHtmlPath:=Get 4D folder:C485(Current resources folder:K5:16; *)+"google-map-templates"+Folder separator:K24:12+"map_location_rendered.html"
			
			If (Test path name:C476($templateHtmlPath)=Is a document:K24:1)
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
					
					//if this form is contained in AddressDistance form
					C_POINTER:C301($parentContainerPtr)
					$parentContainerPtr:=OBJECT Get pointer:C1124(Object subform container:K67:4)
					If ($parentContainerPtr#Null:C1517)
						$parentContainerPtr->:=New object:C1471("lat"; $geocodeResult.lat; "lng"; $geocodeResult.lng)
					End if 
				End if 
				
			End if 
			
		Else 
			myAlert(JSON Stringify:C1217($errorObj))
		End if 
		
End case 
