Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		Form:C1466.sendCurrency:=ds:C1482.CompanyInfo.all().first().Currency
		
		mgFillCurrencyName("sendCurrencyName"; Form:C1466.sendCurrency)
		mgFillCountryName("#destinationCountryName"; Form:C1466.destinationCountry)
		
		Form:C1466.countries:=mgGetCountryCodes
		
		OBJECT SET ENABLED:C1123(*; "btn_send"; False:C215)
		OBJECT SET ENABLED:C1123(*; "btn_get@"; False:C215)
		
		If (Form:C1466.fromSend#Null:C1517)
			
			If (Form:C1466.fromSend)
				OBJECT SET VISIBLE:C603(*; "btn_send"; True:C214)
				OBJECT SET ENABLED:C1123(*; "btn_get@"; True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*; "btn_send"; False:C215)
				OBJECT SET ENABLED:C1123(*; "btn_get@"; False:C215)
			End if 
			
		End if 
		
End case 
