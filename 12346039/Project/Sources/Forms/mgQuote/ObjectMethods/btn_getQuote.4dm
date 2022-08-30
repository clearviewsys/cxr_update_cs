C_OBJECT:C1216($option)
C_TEXT:C284($msg)

If ((Form:C1466.destinationCountry#"") & (Form:C1466.sendAmount>0))
	
	Form:C1466.quotes:=mgGetQuote(Form:C1466.sendAmount; Form:C1466.sendCurrency; \
		Form:C1466.destinationCountry; "QINC_FEE"; Form:C1466.promotionCode)
	
	If (Form:C1466.quotes#Null:C1517)
		
		If (Form:C1466.quotes.success)
			
			For each ($option; Form:C1466.quotes.result)
				$option.countryCode:=mgCountryID2CountryCode(Num:C11($option.Country))
				$option.tCurrency:=mgCurrencyID2CurrencyCode(Num:C11($option.TransferCurrency))
				$option.tSendCurrency:=mgCurrencyID2CurrencyCode(Num:C11($option.TransferSendCurrency))
			End for each 
			
		Else 
			
			$msg:=mgGetSOAPErrorDetails(Form:C1466.quotes.mgerrormsg)
			
			myAlert($msg)
			
		End if 
		
	End if 
	
Else 
	
	myAlert("Please choose destination country and enter amount to send.")
	
End if 
