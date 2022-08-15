Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		
		ALL RECORDS:C47([CompanyInfo:7])
		Form:C1466.sendCurrency:=[CompanyInfo:7]Currency:11
		UNLOAD RECORD:C212([CompanyInfo:7])
		
		mgFillCurrencyName("sendCurrencyName"; Form:C1466.sendCurrency)
		mgFillCountryName("#destinationCountryName"; Form:C1466.destinationCountry)
		
		Form:C1466.countries:=mgGetCountryCodes
		
		OBJECT SET ENABLED:C1123(*; "btn_send"; False:C215)
		
		If (Form:C1466.fromSend#Null:C1517)
			
			If (Form:C1466.fromSend)
				OBJECT SET VISIBLE:C603(*; "btn_send"; True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*; "btn_send"; False:C215)
			End if 
			
		End if 
		
End case 
