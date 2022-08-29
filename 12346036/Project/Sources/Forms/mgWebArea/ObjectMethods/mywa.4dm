C_TEXT:C284($url; $url2; $fileName)

Case of 
		
	: (Form event code:C388=On Window Opening Denied:K2:51)
		
		
		$url:=WA Get last filtered URL:C1035(*; Form:C1466.mywa)
		
		If ($url#"")
			
			Form:C1466.deniedURL:=$url
			
		End if 
		
		
		
	: (Form event code:C388=On End URL Loading:K2:47)
		
		
		$url2:=Form:C1466.session.endpoints.afterFinishURL+"@"
		
		$url:=WA Get current URL:C1025(*; Form:C1466.mywa)
		
		SET WINDOW TITLE:C213($url)
		
		Case of 
				
			: (($url=Form:C1466.session.endpoints.loginURL) | ($url=Form:C1466.session.endpoints.newSession))
				
				Form:C1466.msg:="Loging to MoneyGram Profix Web app ..."
				
				If (Form:C1466.useOldLogin)
					If (Form:C1466.session.languageSet=Null:C1517)
						waSetSelected(Form:C1466.mywa; "ddlLanguage"; "English")
						waForceOnChange("mywa"; "ddlLanguage")
						Form:C1466.session.languageSet:=True:C214
						Form:C1466.msg:="Loging to MoneyGram Profix Web app - language set to English"
						DELAY PROCESS:C323(Current process:C322; 35)
					End if 
				End if 
				
				DELAY PROCESS:C323(Current process:C322; 30)
				
				Form:C1466.msg:="Loging to MoneyGram Profix Web app - filling credentials"
				
				mgFillCredentials(Form:C1466.credentials)
				
				DELAY PROCESS:C323(Current process:C322; 62)
				
				waClickOnElement(Form:C1466.mywa; "LoginButton")  // submit login form
				
				
				
			: ($url=Form:C1466.session.endpoints.afterLoginURL)
				
				Form:C1466.msg:="Fetching local data"
				
				mgWebArea_fillFormData
				
				DELAY PROCESS:C323(Current process:C322; 60)
				
				Form:C1466.msg:="Submiting data to MoneyGram ..."
				
				waClickOnElement(Form:C1466.mywa; "submit")
				
				
				DELAY PROCESS:C323(Current process:C322; 60)
				
				
				
			: (($url=Form:C1466.session.endpoints.sendURL) | ($url=Form:C1466.session.endpoints.receiveURL))  // after submitting the form to Profix
				
				OBJECT SET VISIBLE:C603(*; "msgArea"; False:C215)
				WA OPEN URL:C1020(*; Form:C1466.mywa; Form:C1466.afterSubmitURL)
				OBJECT SET VISIBLE:C603(*; Form:C1466.mywa; True:C214)
				
				
				
			: ($url=$url2)  // URL is appended with some values
				
				
				Form:C1466.value:=waGetValue(Form:C1466.mywa; Form:C1466.valueElement)
				Form:C1466.valueObject:=mgGetResultData(Form:C1466.value)  // convert data into 4D object
				
				// create record in WebeWires table
				
				If (Form:C1466.winref#Null:C1517)
					If (Form:C1466.valueObject#Null:C1517)
						
						// CALL FORM(Form.winref;"mgGetResult";Form.valueObject)
						
						C_OBJECT:C1216($pass)
						$pass:=New object:C1471
						$pass.result:=Form:C1466.valueObject
						$pass.object:=Form:C1466.object
						$pass.customerID:=Form:C1466.customerID
						
						If (Form:C1466.WebewireID#Null:C1517)  // Lotus had two receive webeiwres created in one branch
							// reserve invoice for this MoneyGram Transaction
							If (Form:C1466.WebewireID#"")
								C_OBJECT:C1216($invoiceOK)
								$invoiceOK:=mgReserveInvoicebyWebEwire(Form:C1466.customerID)
								If ($invoiceOK.success)
									myAlert("Ïnvoice number "+$invoiceOK.InvoiceID+" reserved for MoneyGram transaction number "+Form:C1466.WebewireID)
								Else 
									myAlert("MoneyGram transaction created with ID: "+Form:C1466.WebewireID)
								End if 
							End if 
						End if 
						
						
					Else 
						$fileName:=System folder:C487(Desktop:K41:16)+"mgmywaerr"+String:C10(Tickcount:C458)
						Form:C1466.webAreaContent:=WA Get page content:C1038(Form:C1466.mywa)
						TEXT TO DOCUMENT:C1237($fileName; JSON Stringify:C1217(Form:C1466; *); "UTF-8")
						myAlert("Couldn't get result from MoneyGram. Please send content of"+$fileName+"to developers")
					End if 
				End if 
				
				If (Form:C1466.deniedURL#Null:C1517)
					If (Form:C1466.deniedURL#"")
						SET WINDOW TITLE:C213("Print your receipt ...")
						WA OPEN URL:C1020(*; Form:C1466.mywa; Form:C1466.deniedURL)
					End if 
				End if 
				
				
		End case 
		
End case 
