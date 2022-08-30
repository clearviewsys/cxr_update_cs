//If (Form event=On Load )
//cbAutoRefresh:=Num(◊isRefreshRatesOnByDefault)
//End if 

If (Self:C308->=1)
	updateSelectedQuotesUsingYahoo
	ORDER BY:C49([Currencies:6]; [Currencies:6]CurrencyCode:1; >)
	
End if 

If (Self:C308->=0)
	CONFIRM:C162("Are you sure you want to turn off automatic update?"; "Keep On"; "Turn Off")
	If (Ok=1)
		Self:C308->:=1
	Else 
		Self:C308->:=0
		cbAutoPublish:=0
	End if 
End if 