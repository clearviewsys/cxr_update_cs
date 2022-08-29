// called by: mgNewCustomerTransaction_OM


Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		If (isUserDesigner)
			OBJECT SET VISIBLE:C603(*; "btn_soap"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "btn_soap"; False:C215)
		End if 
		
		Form:C1466.useOldLogin:=False:C215
		Form:C1466.canCloseWindow:=True:C214
		
		mgSetHelpTips(Form:C1466)
		
		OBJECT SET FONT:C164(*; "password"; "%Password")
		
		If (Shift down:C543)
			OBJECT SET VISIBLE:C603(*; "btn_send2"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "btn_send2"; False:C215)
		End if 
		
		Form:C1466.countries:=mgGetCountryCodes
		
		If (Form:C1466.countries#Null:C1517)
			
			mgFillCountryName("senderCountryName"; Form:C1466.object.senderCountry; Form:C1466.countries)
			mgFillCountryName("senderBirthCountryName"; Form:C1466.object.senderBirthCountry; Form:C1466.countries)
			mgFillCountryName("senderPhotoIdCountryName"; Form:C1466.object.senderPhotoIdCountry; Form:C1466.countries)
			mgFillCountryName("receiverCountryName"; Form:C1466.object.receiverCountry; Form:C1466.countries)
			
			Form:C1466.photoIDList:=mgAssignPhotoIDList("senderPhotoIdType")
			
			Form:C1466.marketing:=mgBuildMarketingStuff
			
			mgMakeMarketingPopup(Form:C1466.marketing)
			
			Form:C1466.object.marketingNotification:=""
			
		Else 
			
			myAlert("Couldn't fetch list of countries")
			
			CANCEL:C270
			
		End if 
		
	: (Form event code:C388=On Unload:K2:2)
		
		CLEAR LIST:C377(Form:C1466.photoIDList; *)
		
		
	: (Form event code:C388=On Close Box:K2:21)
		
		If (Form:C1466.canCloseWindow#Null:C1517)
			If (Form:C1466.canCloseWindow)
				CANCEL:C270
			Else 
				myAlert("You can't close window before process in Profix web application is not finished.")
			End if 
		End if 
		
		
End case 
