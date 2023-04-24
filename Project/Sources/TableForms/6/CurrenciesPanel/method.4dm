C_TEXT:C284(vTimeStamp)

handleListForm

If (Form event code:C388=On Load:K2:1)
	SET TIMER:C645(60*30)
	C_REAL:C285(vBuyUS; vSellUS; vBuyEURO; vSellEURO)
	vBuyUS:=0
	vSellUS:=0
	vBuyEURO:=0
	vSellEURO:=0
End if 

If ((Form event code:C388=On Timer:K2:25) | (Form event code:C388=On Activate:K2:9) | (Form event code:C388=On Outside Call:K2:11))
	C_TEXT:C284(vGroup)
	If (vGroup="")
		ALL RECORDS:C47([Currencies:6])
	Else 
		QUERY:C277([Currencies:6]; [Currencies:6]CurrencyGroup:34=vGroup)
	End if 
	AllRecordsRatesPanel
	vTimeStamp:=getLocalizedString("Rates updated on ")+String:C10(Current date:C33)+" at "+String:C10(Current time:C178; "")
	//selectFavoriteCurrencies 
End if 

