C_TEXT:C284($url; $url2)

Case of 
		
	: (Form event code:C388=On Window Opening Denied:K2:51)
		
		
		$url:=WA Get last filtered URL:C1035(*; Form:C1466.mywa)
		
		If ($url#"")
			
			// TRACE
			
			// mgOpenDeniedURL (New object("URL";$url;"credentials";Form.credentials))
			
			Form:C1466.deniedURL:=$url
			
		End if 
		
		
		
	: (Form event code:C388=On End URL Loading:K2:47)
		
		
		// TRACE
		$url2:=Form:C1466.session.endpoints.afterFinishURL+"@"
		
		$url:=WA Get current URL:C1025(*; Form:C1466.mywa)
		
		//SET WINDOW TITLE($url+" waiting for "+Form)
		
		Case of 
				
			: ($url=Form:C1466.session.endpoints.loginURL)
				
				If (Form:C1466.session.languageSet=Null:C1517)
					waSetSelected(Form:C1466.mywa; "ddlLanguage"; "English")
					waForceOnChange("mywa"; "ddlLanguage")
					Form:C1466.session.languageSet:=True:C214
				End if 
				
				DELAY PROCESS:C323(Current process:C322; 60)
				
				//mgFillCredentials (Form.credentials)
				
				//DELAY PROCESS(Current process;120)
				
				//waClickOnElement (Form.mywa;"LoginButton")  // submit login form
				
				
				
			: ($url=Form:C1466.session.endpoints.afterLoginURL)
				
				
				//mgWebArea_fillFormData 
				
				//DELAY PROCESS(Current process;60)
				
				//waClickOnElement (Form.mywa;"submit")
				
				
				//DELAY PROCESS(Current process;60)
				
				
				
			: ($url=Form:C1466.session.endpoints.sendURL)  // after submitting the form to Profix
				
				
				// WA OPEN URL(*;Form.mywa;Form.afterSubmitURL)
				
				
				
			: ($url=$url2)  // URL is appended with some values
				// : ($url=Form.session.endpoints.afterFinishURL+"@")  // URL is appended with some values - this generates runtime error
				
				// TRACE
				
				Form:C1466.value:=waGetValue(Form:C1466.mywa; Form:C1466.valueElement)
				Form:C1466.valueObject:=mgGetResultData(Form:C1466.value)  // convert data into 4D object
				
				// create record in calling form
				
				If (Form:C1466.winref#Null:C1517)
					CALL FORM:C1391(Form:C1466.winref; "mgGetResult"; Form:C1466.valueObject)
				End if 
				
				// waClickOnElement (Form.mywa;"ctl00_ContentPlaceHolder1_TransferDetailLink")  // Click on "Show" label in the form
				If (Form:C1466.deniedURL#Null:C1517)
					If (Form:C1466.deniedURL#"")
						SET WINDOW TITLE:C213("Print your receipt ...")
						WA OPEN URL:C1020(*; Form:C1466.mywa; Form:C1466.deniedURL)
					End if 
				End if 
				
		End case 
		
End case 


