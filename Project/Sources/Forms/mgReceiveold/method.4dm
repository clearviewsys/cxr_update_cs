
Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
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
		
End case 
