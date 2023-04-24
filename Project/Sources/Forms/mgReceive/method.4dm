
Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		Form:C1466.canCloseWindow:=True:C214
		
		OBJECT SET ENABLED:C1123(*; "btn_receive"; False:C215)
		
		OBJECT SET FONT:C164(*; "password"; "%Password")
		
		mgSetHelpTips(Form:C1466)
		
		If (Shift down:C543)
			OBJECT SET VISIBLE:C603(*; "btn_receive2"; True:C214)
		End if 
		
		Form:C1466.countries:=mgGetCountryCodes
		
		mgFillCountryName("receiverCountryName"; Form:C1466.object.receiverCountry; Form:C1466.countries)
		mgFillCountryName("receiverBirthCountryName"; Form:C1466.object.receiverBirthCountry; Form:C1466.countries)
		mgFillCountryName("receiverPhotoIdCountryName"; Form:C1466.object.receiverPhotoIdCountry; Form:C1466.countries)
		
		Form:C1466.photoIDList:=mgAssignPhotoIDList("receiverPhotoIdType")
		
		
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
